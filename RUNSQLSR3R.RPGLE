**free
       //-------------------------------------------------------------------------------------------
       // RUNSQLSR3R - Scan and Remove SQL comment lines containing: -- for comments.
       //-------------------------------------------------------------------------------------------
       DCL-F TMPQRYSRC  DISK(*EXT)
                         Usage(*UPDATE:*DELETE) RENAME(TMPQRYSRC:TMPSRCR);

       // Program DS
       Dcl-Ds *N psds;
          PROGID *PROC;
       End-Ds;

       // Program *entry parameter list prototype
       Dcl-pi RUNSQLSR3R;
          p_dltcmtline CHAR(4);
          p_rtnerror CHAR(1);
       End-pi ;

       DCL-S posfound int(10);

       // Initialize parm arrays from passed in values
       p_rtnerror='0';

       // Monitor for errors
       Monitor;

         // Set to beginning of file
         setll *start tmpqrysrc;

         // Read all records in source member and scan/replace
         // keyword values if not a comment line starting with: --
         dou %eof(tmpqrysrc);

           // Read next record
           read tmpqrysrc;

           // If end of file, exit process loop
           if %eof(tmpqrysrc);
             leave;
           endif;

           // Scan and replace parm values into SQL statement.
           if %trim(srcdta) <> '';

             // Remove comment lines from SQL
             // Locate start of comment
             posfound=%scan('--':srcdta);

             // If comment in pos 1 or 2, clear entire line
             if (posfound=1 or posfound=2);
               srcdta=*blanks;
             elseif (posfound>2);
               // Get substring and elim text after --
               // This gets rid of comments after SQL data.
               srcdta=%subst(srcdta:1:posfound-1);
             endif;

             // Update line or delete if empty after it was scrubbed
             // of the comments.
             if %trim(srcdta) <> '';
                // Update temporary SQL source member with changes
                update tmpsrcr;
             else;
                // Only do actual delete if parm passed as such
                if (p_dltcmtline= '*YES');
                    // Remove blank line from source member
                    delete tmpsrcr;
                else;
                    // Update temporary SQL source member with changes
                    update tmpsrcr;
                endif;
             endif;

           else; // Blank line. Delete from temp source member
             // Remove blank line from source member
             delete tmpsrcr;
           endif;

         enddo;
     // Monitor for errors
     On-Error;
          p_rtnerror='1';
          *inlr=*on;
          return;
     Endmon;

     // Exit
     *inlr=*on;
     return;
