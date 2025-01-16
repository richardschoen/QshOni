**free
       //-------------------------------------------------------------------------------------------
       // QSHLOGSCAR - Scan Qshell Log File for Selected Value(s)
       //-------------------------------------------------------------------------------------------
       Dcl-F STDOUTQSH  DISK(1000) Usage(*Input);

       Dcl-Ds *N psds;
         PROGID *PROC;
       End-Ds;

       Dcl-Ds qshlog;
         record1 char(1000);
       End-Ds;

       // Parameter name list passed from CL
       Dcl-Ds parmscanfor;
         scancount bindec(4);
         scanvals char(100) dim(20);
       End-Ds;

       // Program *entry parameter list prototype
       Dcl-pi QSHIFSSCAR;
          p_values  CHAR(2002);
          p_exactmatch CHAR(4);
          p_rtnfound CHAR(1);
          p_rtnval   CHAR(100);
       End-pi ;

       DCL-S curelem packed(5:0);
       DCL-S vvalue varchar(100);
       DCL-S ifound packed(5:0);

       p_RtnVal=*blanks;
       p_RtnFound='0';
       // Initialize parm arrays from passed in values
       p_rtnfound='0';
       parmscanfor=p_values;

       // If no scan value passed, bail out now
       if (scancount=0);
          p_RtnFound='0';
          *inlr=*on;
          return;
       endif;

       // Set to beginning of file
       setll *start STDOUTQSH;

       // Read all selected documents and extract keywords                  ------------------------
       dou %eof(STDOUTQSH);

         // Read next record
         read STDOUTQSH qshlog;
         // If end of file, exit process loop
         if %eof(STDOUTQSH);
             p_RtnFound='0';
             *inlr=*on;
             return;
         endif;

         // Loop through all passed in values
         // for current file data line.
         // Once a value is found, exit
         for curelem = 1 to scancount;

            // Extract scanfor value
            vvalue=%trim(scanvals(curelem));

            // See if an exact value match to log entry ?
            if p_ExactMatch = '*YES' ;
               if %trim(vvalue) = %trim(QSHLOG);
                 p_rtnval=vvalue;
                 p_RtnFound='1';
                 *inlr=*on;
                 return;
               endif;
            // Do a contains search to check for value in string
            else;
               if %scan(%trim(vvalue):qshlog) > 0;
                 p_rtnval=vvalue;
                 p_RtnFound='1';
                 *inlr=*on;
                 return;
               endif;
            endif;

         endfor;

       enddo;

       // Exit
       *inlr=*on;
       return;
