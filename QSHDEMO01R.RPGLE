       //-------------------------------------------------------------------------------------------
       // QSHDEMO01R - Read QSHELL log file STDOUTQSH from QTEMP and display
       //              the first 52 bytes of each record with DSPLY as an
       //              example. Your apps could do whatever they want with
       //              the returned data.
       //-------------------------------------------------------------------------------------------
       Dcl-F STDOUTQSH  DISK(1000) Usage(*Input) USROPN;

       Dcl-Ds *N psds;
         PROGID *PROC;
       End-Ds;

       Dcl-Ds qshlogrec;
         record1 char(1000);
       End-Ds;

       Dcl-S recdsp1 Char(52);
       Dcl-S p_Value Char(1024);
       Dcl-S p_ExactMatch char(4);
       Dcl-S p_RtnFound char(1);
     
     C*    *entry        plist
     C*                  parm                    p_Value
     C*                  parm                    p_ExactMatch
     C*                  parm                    p_RtnFound

       p_RtnFound='0';


       // Monitor for errors
       monitor;

       // Attempt to open file
       open STDOUTQSH;

       // Set to beginning of file
       setll *start STDOUTQSH;

       // Read all records from the STDOUTQSH log file and process
       // as needed. This example simply displays each entry.  
       dou %eof(STDOUTQSH);

         // Read next record
         READ STDOUTQSH qshlogrec;

         // If end of file, exit process loop
         if %eof(STDOUTQSH);
           leave;
         endif;

         recdsp1=record1;
         DSPLY recdsp1;

       enddo;

       // Attempt to close file
       close stdoutqsh;
       ON-ERROR;
         DSPLY 'Error occured. Check joblog.';
       ENDMON;

       // Exit program. we're done
       *inlr=*on;
       return;
