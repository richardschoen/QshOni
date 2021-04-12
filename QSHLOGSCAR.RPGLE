       //-------------------------------------------------------------------------------------------
       // QSHLOGSCAR - Scan Qshell Log File for Selected Value
       //-------------------------------------------------------------------------------------------
       Dcl-F STDOUTQSH  DISK(1000) Usage(*Input);

       Dcl-Ds *N psds;
         PROGID *PROC;
       End-Ds;

       Dcl-Ds qshlog;
         record1 char(1000);
       End-Ds;

       Dcl-S p_Value Char(1024);
       Dcl-S p_ExactMatch char(4);
       Dcl-S p_RtnFound char(1);
     
     C     *entry        plist
     C                   parm                    p_Value
     C                   parm                    p_ExactMatch
     C                   parm                    p_RtnFound

       p_RtnFound='0';

       // Set to beginning of file
       setll *start STDOUTQSH;

       // Read all selected documents and extract keywords               
       dou %eof(STDOUTQSH);

         // Read next record
         read STDOUTQSH qshlog;
         // If end of file, exit process loop
         if %eof(STDOUTQSH);
           leave;
         endif;

         // See if an exact value match to log entry ?
         if p_ExactMatch = '*YES' ;
            if %trim(p_Value) = %trim(QSHLOG);
              p_RtnFound='1';
              leave;
            endif;
         // Do a contains search to check for value in string
         else;
            if %scan(%trim(p_Value):qshlog) > 0;
              p_RtnFound='1';
              leave;
            endif;
         endif;

       enddo;

       // Exit
       *inlr=*on;
       return;
