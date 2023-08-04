      //-------------------------------------------------------------------------------------------
      // QSHGETPARR - Scan Qshell Log File for Selected Return Values
      //-------------------------------------------------------------------------------------------
       Dcl-F STDOUTQSH  DISK(1000) Usage(*Input);

       Dcl-Ds *N psds;
         PROGID *PROC;
       End-Ds;

       Dcl-Ds qshlog;
         record1 char(1000);
       End-Ds;

       Dcl-S p_Return01 Char(255);
       Dcl-S p_Return02 Char(255);
       Dcl-S p_Return03 Char(255);
       Dcl-S p_Return04 Char(255);
       Dcl-S p_Return05 Char(255);
       Dcl-S p_Return06 Char(255);
       Dcl-S p_Return07 Char(255);
       Dcl-S p_Return08 Char(255);
       Dcl-S p_Return09 Char(255);
       Dcl-S p_Return10 Char(255);
       Dcl-S p_Value Char(1024);
       Dcl-S p_ExactMatch char(4);
       Dcl-S p_RtnFound char(1);
       Dcl-S p_Count int(10);
    
     C     *entry        plist
     C                   parm                    p_Return01
     C                   parm                    p_Return02
     C                   parm                    p_Return03
     C                   parm                    p_Return04
     C                   parm                    p_Return05
     C                   parm                    p_Return06
     C                   parm                    p_Return07
     C                   parm                    p_Return08
     C                   parm                    p_Return09
     C                   parm                    p_Return10

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
         if %scan('RETURNPARM01:':qshlog) > 0;
            p_Return01=%subst(qshlog:14:255);
         endif;
         if %scan('RETURNPARM02:':qshlog) > 0;
            p_Return02=%subst(qshlog:14:255);
         endif;
         if %scan('RETURNPARM03:':qshlog) > 0;
            p_Return03=%subst(qshlog:14:255);
         endif;
         if %scan('RETURNPARM04:':qshlog) > 0;
            p_Return04=%subst(qshlog:14:255);
         endif;
         if %scan('RETURNPARM05:':qshlog) > 0;
            p_Return05=%subst(qshlog:14:255);
         endif;
         if %scan('RETURNPARM06:':qshlog) > 0;
            p_Return06=%subst(qshlog:14:255);
         endif;
         if %scan('RETURNPARM07:':qshlog) > 0;
            p_Return07=%subst(qshlog:14:255);
         endif;
         if %scan('RETURNPARM08:':qshlog) > 0;
            p_Return08=%subst(qshlog:14:255);
         endif;
         if %scan('RETURNPARM09:':qshlog) > 0;
            p_Return09=%subst(qshlog:14:255);
         endif;
         if %scan('RETURNPARM10:':qshlog) > 0;
            p_Return10=%subst(qshlog:14:255);
         endif;

       enddo;

       // Exit
       *inlr=*on;
       return;
