     **free
       //-------------------------------------------------------------------------------------------
       // QSHQRYSRCR - SQL Query Data via Source Member to Temp Table
       // Read SQL statement in from source member and write to query
       // variable. A blank space is appended at end of each line as
       // the query builds out.
       //-------------------------------------------------------------------------------------------
       Dcl-F TMPSRCMBR  DISK(400) Usage(*Input);

       Dcl-Ds *N psds;
          PROGID *PROC;
       End-Ds;

       // Temporary record from source member
       Dcl-Ds tmprcd;
         srcinfo char(12);
         srcdta char(388);
       End-Ds;

       // Program *entry parameter list prototype
       Dcl-pi QSHQRYSRCR;
          p_SQL char(5000);
       End-pi ;

       // Set to beginning of file
       setll *start tmpsrcmbr;

       // Read all selected documents and extract keywords
       dou %eof(tmpsrcmbr);

         // Read next record
         read tmpsrcmbr tmprcd;

         // If end of file, exit process loop
         if %eof(tmpsrcmbr);
           leave;
         endif;

         // Append SQL statement parts if lline not blanks.
         // Always inject a single blank space at the end
         // Assume that SQL source members are structured
         // as such.
         if %trim(srcdta) <> '';
            p_SQL = %trim(p_SQL) +' ' + %trim(srcdta);
         endif;

       enddo;

       // Exit
       *inlr=*on;
       return;
