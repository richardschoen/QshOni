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
  Dcl-S rtnparm01          Char(255) inz('');
  Dcl-S rtnparm02          Char(255) inz('');
  Dcl-S rtnparm03          Char(255) inz('');
  Dcl-S rtnparm04          Char(255) inz('');
  Dcl-S rtnparm05          Char(255) inz('');
  Dcl-S rtnparm06          Char(255) inz('');
  Dcl-S rtnparm07          Char(255) inz('');
  Dcl-S rtnparm08          Char(255) inz('');
  Dcl-S rtnparm09          Char(255) inz('');
  Dcl-S rtnparm10          Char(255) inz('');
  Dcl-S cmdlin             VarChar(5000) inz('');

 // Include QSHONISRV service program prototypes
 /copy qshoni/source,qshonisrvh

   // Sample CL command call. 0=Success, -2=Errors
   // Uncomment if you want to test calling a CL command.
   // rtncmd=RunClCmd('SNDMSG MSG(TEST) TOUSR(QSYSOPR);

   // Sample QSHCALL QShell/PASE command call. 0=Success, -2=Errors
   // We will call Qsh/Pase script and return parms in the stdout
   // information of the script if any parm info.
   // Otherwise we can still read and process the STDOUTQSH outfile
   // if there is other info we need to process from the call.

   // Set sample PHP comand line
   cmdlin='cd /tmp/qshoni/qshphp;+   
          php phpcallparm1.php';
   // Run the PHP script and return parms
   rtncmd=QshCall(cmdlin:            // QSH/PASE command line
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
                  '*NO':
                  rtnparm01:
                  rtnparm02:
                  rtnparm03:
                  rtnparm04:
                  rtnparm05:
                  rtnparm06:
                  rtnparm07:
                  rtnparm08:
                  rtnparm09:
                  rtnparm10);

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

