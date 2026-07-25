**free
       //-------------------------------------------------------------------------------------------
       // QSHQRYSR3R - Scan and Remove SQL comment lines containing: -- for comments.
       //-------------------------------------------------------------------------------------------
       DCL-F TMPQRYSRC  DISK(*EXT)
                         Usage(*UPDATE:*DELETE) RENAME(TMPQRYSRC:TMPSRCR);

       // Program DS
       Dcl-Ds *N psds;
          PROGID *PROC;
       End-Ds;

       // Program *entry parameter list prototype
       Dcl-pi QSHQRYSR3R;
          p_dltcmtline CHAR(4);
          p_rtnerror CHAR(1);
       End-pi ;

       DCL-S posfound int(10);

       // Initialize parm arrays from passed in values
       p_rtnerror='0';

       // Do not mess with source member if not deleting comments
       // Added to skip any source member manipulation when
       // delete comments = *NO - 7/24/2026
       if p_dltcmtline = '*NO';
          *inlr=*on;
          return;
       endif;

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
             // Now based on trimmed line - 7/24/2026
             //posfound=%scan('--':srcdta);
             posfound=%scan('--':%trim(srcdta));

             // If comment in pos 1 or 2, clear entire line
             if (posfound=1 or posfound=2);
               srcdta=*blanks;
             elseif (posfound>2);
               // Get substring and elim text after --
               // This gets rid of comments after SQL data.
               // Rmv this as it trims potentially good data. 7/24/2026
               // We no longer remove comments not at beginning.
               // And we only remove them when in position 1 and 2
               // srcdta=%subst(srcdta:1:posfound-1);
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
