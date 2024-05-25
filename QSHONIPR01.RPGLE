**FREE

Ctl-Opt DFTACTGRP(*NO) BNDDIR('QSHONI/QSHONISRV') OPTION(*SRCSTMT);

Dcl-F STDOUTQSH  DISK(1000) Usage(*Input) usropn;

//TODO:
// Retrieve error message and CPF ID on failure if needed.

 Dcl-Ds *N psds;
   PROGID *PROC;
 End-Ds;

 Dcl-Ds qshlog;
   logrecord char(1000);
 End-Ds;

  // Work fields
  Dcl-S qt                    Char(1) inz('''');
  Dcl-S clcmd              VarChar(5000) inz('');
  dcl-s rtncmd int(10);

 // Include QSHONISRV service program prototypes
 /copy qshoni/source,qshonisrvh

   // Sample CL command call. 0=Success, -2=Errors
   // Uncomment if you want to test calling a CL command.
   // rtncmd=RunClCmd('SNDMSG MSG(TEST) TOUSR(QSYSOPR);

   // Sample QSHEXEC QShell/PASE command call. 0=Success, -2=Errors
   // Prompt for the CL command and display STDOUT after run.
   // Lists files in /tmp directory.
   rtncmd=QshExec('cd /tmp;ls -l':   // QSH/PASE command line
                  '*YES':            // SETPKGPATH
                  '*YES':            // DSPSTDOUT
                  '*NO':             // LOGSTDOUT
                  '*NO':             // PRTSTDOUT
                  '*YES':            // DLTSTDOUT
                  '*NO':             // IFSSTDOUT
                  '':                // IFSFILE
                  '*REPLACE':        // IFSOPT
                  '*SAME':           // CCSID
                  'QSHONIPR1':       // PRTSPLF
                  '':                // PRTUSRDTA
                  '':                // PRTTXT
                  '*NO':             // PRTHOLD
                  '*SAME':           // PRTOUTQ
                  'QTEMP/STDOUTQSH': // OUTFILE
                  '*REPLACE':        // MBROPT
                  '*DEFAULT':        // PASEJOBNAM
                  '*YES');// Prompt Command (Interactive debug or use)

    // Note: This section reads the STDOUT log file.
    //       Make sure to only create STDOUTQSH in QTEMP library
    //       so the job only gets its own STDOUTQSH file.

    // Open log file and set to beginning of
    open STDOUTQSH;
    setll *start STDOUTQSH;

    // Read all records in QTEMP/STDOUTQSH file
    dou %eof(STDOUTQSH);

      // Read next record from STDOUTQSH
      read STDOUTQSH qshlog;

      // Process and scan or extract info from record1 field as needed

      // If end of file, exit process loop
      if %eof(STDOUTQSH);
        leave;
      endif;

    enddo;


   // Exit the program now. We're done
   close STDOUTQSH;
   *inlr=*on;
   return;

