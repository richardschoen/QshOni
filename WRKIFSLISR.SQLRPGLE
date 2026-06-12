**free
ctl-opt dftactgrp(*no) actgrp(*caller)
        option(*srcstmt:*nodebugio);

dcl-f WRKIFSLISD workstn sfile(SFL01:rrn)
                      sfile(msgsfl:rrn2);

dcl-s rrn        packed(4:0) inz(0);
dcl-s rrn2       packed(4:0) inz(1);
dcl-s maxRows    packed(4:0) inz(9998);
dcl-s cmd        varchar(32702);
dcl-s cmdLen     packed(15:5);
dcl-s fullPath   varchar(500);
dcl-s objtype    varchar(500);
dcl-s escPath    varchar(1000);
dcl-s opt        varchar(3);
dcl-s done       ind inz(*off);
dcl-s reload     ind inz(*on);
dcl-s pathLen    int(10);
dcl-s dirname    varchar(255);
dcl-s dirsave    char(100);
dcl-s pattern2   varchar(15);
dcl-s patternsave   varchar(15);
dcl-s filetypesave  varchar(10);
dcl-s filetype2  varchar(10);

dcl-pr QCMDEXC extpgm('QCMDEXC');
  command char(32702) const options(*varsize);
  length  packed(15:5) const;
end-pr;

dcl-pr IFSLISTCMD extpgm('WRKIFSCMD');
  cmdopt char(3) const;
  ifspath char(255) const;
  topgm  char(10) const;
end-pr;

dcl-pr IFSGETHOME extpgm('QSHGETHOME');
  homedir char(640);
end-pr;

dcl-s rtnhome char(640);

dcl-pi *n;
  inDir char(255) const;
  inOptDesc char(160) const;
end-pi;

Dcl-Ds *N psds;
   PROGID *PROC;
End-Ds;

// Initial directory.
// You can change this default or pass it in as a parameter.
optdesc=inoptdesc;
dir = %trim(inDir);
pattern='*.*';
filetype='';

//msgq = 'IFSLISTR';
pgmq=PROGID;
//msgq = '*';

// Main loop. Do until F3 pressed to exit.
dow not done;

  // Reload subfile if F5 pressed, otherwise just display subfile.
  if reload;
     loadSubfile();
     // Set saved dir and pattern to current so we only reload if they change.
     dirsave = dir;
     patternsave = pattern;
     filetypesave = filetype;
     reload = *off;
     rrn = 1;
  endif;

  // Display cmd keys and subfile and get user input.
  write CMD01;
  write MSGSFLC;
  exfmt CTL01;

  // Clear message subfile for new messages.
  //*in51 = *on;
  //write MSGSFL;
  //*in51 = *off;

  // If F3 pressed, set done to exit loop, otherwise
  if *in03;
     done = *on;
     iter;
  endif;

  // If F5 pressed, set reload to reload subfile.
  if *in05;
     reload = *on;
     iter;
  endif;

  // If F8 pressed, set home dir and reload subfile
  if *in08;
     ifsgethome(rtnhome);
     dir = %trim(rtnhome);
     reload = *on;
     iter;
  endif;

  // If F12 pressed, move back one level
  if *in12;
     dir = GetParentPath(dir);
     reload = *on;
     iter;
  endif;

  // If F10 pressed, display joblog
  if *in10;
     runIbmICommand('DSPJOBLOG');
     iter;
  endif;

  // If F21 pressed, display command line
  if *in21;
     runIbmICommand('CALL QUSCMDLN');
     iter;
  endif;

  // Process options for selected records if no change
  // in dirctory or pattern, otherwise just reload subfile
  // with new directory/pattern.
  if dir <> dirsave or pattern <> patternsave or
     filetype <> filetypesave;
     reload = *on;
     dirsave = dir;
     patternsave = pattern;
     filetypesave = filetype;
  else;
     processOptions();
  endif;

enddo;

// Exit program
*inlr = *on;
return;

// ------------------------------------------------------------
// Load subfile from IFS_OBJECT_STATISTICS DB2 Service table function.
// This gets list of IFS files in a directory without having to
// use QShell or other command line utilities.
// ------------------------------------------------------------
dcl-proc loadSubfile;

  clear MSG;

  // Clear subfile
  *in31 = *on;
  write CTL01;
  *in31 = *off;

  rrn = 0;
  //RRN = 1;

  // Move dir to varchar field for query
  dirname=%trim(DIR);
  pattern2 = %trim(pattern);
  filetype2 = %trim(filetype);

  if pattern2 = '' or pattern = '*' or pattern = '*.*';
     pattern2 = '%%';
  else;
     // Replace any * with % for SQL like pattern.
     pattern2 = %xlate('*':'%':pattern2);
  endif;

  if filetype2= '';
     filetype2 ='%%';
  endif;

  exec sql
    declare C1 cursor for
      select path_name,object_type
        from table(
               qsys2.ifs_object_statistics(
                 start_path_name => :dirname,
                 subtree_directories => 'NO'
               )
             )
       -- where (object_type = '*STMF' or object_type = '*MBR')
       where (object_type like :filetype2)
       and ((lower(path_name) like :pattern2)
       or (upper(path_name) like :pattern2))
       -- and path_name like :pattern2
       order by path_name;

  exec sql open C1;

  dow rrn < maxRows;

     exec sql fetch C1 into :fullPath,:objtype;

     if sqlcode <> 0;
        leave;
     endif;

     clear SFOPT;
     SFSTMF = fullPath;
     SFTYPE = objtype;

     pathLen = %len(%trim(fullPath));

     if pathLen > %size(SFPATH);
        SFPATH = %subst(fullPath:1:%size(SFPATH));
     else;
        SFPATH = fullPath;
     endif;

     // Loop back to next dir if at top level
     // Those entries are duplicating from the
     // DB2 IFS query.
     if (SFPATH = dir) and (SFTYPE = '*DIR');
        iter;
     endif;
     if (SFPATH = %trim(dir) + '/') and (SFTYPE = '*DIR');
        iter;
     endif;
     if (SFPATH = dir) and (SFTYPE = '*FLR');
        iter;
     endif;
     if (SFPATH = %trim(dir) + '/') and (SFTYPE = '*FLR');
        iter;
     endif;
     if (SFPATH = dir) and (SFTYPE = '*LIB');
        iter;
     endif;
     if (SFPATH = %trim(dir) + '/') and (SFTYPE = '*LIB');
        iter;
     endif;

     rrn += 1;

     // IN52 marks directories blue
     if (sftype = '*DIR' or sftype='*FLR' or sftype='*LIB');
        *IN52=*ON;
     endif;
     write SFL01;
     *IN52=*OFF;

  enddo;

  // Write one last record so we don't get device error when no records.
  rrn += 1;
  SFPATH='';
  // *IN73 hides opt field.
  *in73 = *on;
  write SFL01;
  *in73 = *off;

  exec sql close C1;

  if rrn = 0;
     MSG = 'No entries found in directory.';
     *in32 = *off;
  else;
     MSG = %char(rrn-1) + ' entries found.';
     *in32 = *on;
  endif;

  *in34 = *on;

end-proc;

// ------------------------------------------------------------
// Process changed subfile records
// ------------------------------------------------------------
dcl-proc processOptions;

  readc SFL01;

  dow not %eof(WRKIFSLISD);

     opt = %trim(SFOPT);

     // Only process if not end of list record,
     // otherwise user gets error if they try to select an option on the end of list record.
     if %trim(SFPATH) <> '';

     //        select;
     //
     //        when opt = '5';
     //             runIbmICommand('DSPF STMF(' + quoteCmdParm(%trim(SFSTMF)) + ')');
     //
     //        when opt = '4';
     //             runIbmICommand('? ERASE STMF(' + quoteCmdParm(%trim(SFSTMF)) + ')');
     //
     //        when opt = '2';
     //             runIbmICommand('EDTF STMF(' + quoteCmdParm(%trim(SFSTMF)) + ')');
     //
     //        when opt = *blank;
     //             // Ignore
     //
     //        other;
     //             MSG = 'Invalid option. Use 2=Edit or 5=Display.';
     //
     //        endsl;

     // If dir was selected, reload list
     if (sftype = '*DIR' or sftype='*FLR' or sftype='*LIB') and
        (opt = '2' or opt = '5');
        dir = sfstmf;
        reload=*on;
        return;
     else;
        IFSLISTCMD(opt:%subst(sfstmf:1:255):PGMQ);
     endif;

     endif;

     // Clear the option so we don't re-process if user just moves up and down the list.
     clear SFOPT;

     // IN52 marks directories blue. Otherwise they return to
     // green after processing an option which is confusing
     // if user selected a directory.
     if (sftype = '*DIR' or sftype='*FLR' or sftype='*LIB');
        *IN52=*ON;
     endif;
     update SFL01;
     *IN52=*OFF;

     readc SFL01;

  enddo;

end-proc;


// ------------------------------------------------------------
// Run IBM i command through QCMDEXC
// ------------------------------------------------------------
dcl-proc runIbmICommand;

  dcl-pi *n;
    inCmd varchar(32702) const;
  end-pi;

  cmd = inCmd;
  cmdLen = %len(%trimr(cmd));

  monitor;
     QCMDEXC(cmd: cmdLen);
  on-error;
     MSG = 'Command failed: ' + %subst(cmd:1:60);
  endmon;

end-proc;


// ------------------------------------------------------------
// Quote command parameter and double embedded apostrophes
// Example:
//   /home/bob/a'b.txt
// becomes:
//   '/home/bob/a''b.txt'
// ------------------------------------------------------------
dcl-proc quoteCmdParm;

  dcl-pi *n varchar(1000);
    inValue varchar(500) const;
  end-pi;

  dcl-s i int(10);
  dcl-s out1 varchar(1000) inz('');

  out1 = '''';

  for i = 1 to %len(%trimr(inValue));

     if %subst(inValue:i:1) = '''';
        out1 = out1 + '''''';
     else;
        out1 = out1 + %subst(inValue:i:1);
     endif;

  endfor;

  out1 = out1 + '''';

  return out1;

end-proc;

// ------------------------------------------------------------
// Get parent path of a given IFS path. This is used to move up to
// the parent directory when user selects a directory from the list.
// ------------------------------------------------------------
dcl-proc GetParentPath;

   dcl-pi *n varchar(255);
      inputPath varchar(255) const;
   end-pi;

   dcl-s workPath   varchar(255);
   dcl-s parentPath varchar(255);
   dcl-s lastSlash  int(10);

   workPath = %trimr(inputPath);

   // Empty path
   if workPath = '';
      return '.';
   endif;

   // Remove trailing slash unless root
   dow %len(workPath) > 1
      and %subst(workPath:%len(workPath):1) = '/';

      workPath = %subst(workPath:1:%len(workPath)-1);

   enddo;

   // Root stays root
   if workPath = '/';
      return '/';
   endif;

   lastSlash = %scanr('/': workPath);

   select;
   when lastSlash <= 1;
      parentPath = '/';

   when lastSlash > 1;
      parentPath = %subst(workPath:1:lastSlash-1);

   other;
      parentPath = '.';

   endsl;

   return parentPath;

end-proc;
