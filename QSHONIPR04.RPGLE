**FREE

Ctl-Opt DFTACTGRP(*NO) BNDDIR('QSHONI/QSHONISRV') OPTION(*SRCSTMT);

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
  Dcl-s msgtest            Char(330) inz('');
  Dcl-S cmdlin             VarChar(5000) inz('');

 // Include QSHONISRV service program prototypes
 /copy qshoni/source,qshonisrvh

   // Write to log file, crt new file and no prompt
   rtncmd=QshWrtLog('This is a test':    // Msg text
           'INFO':                       // Msg type
           'LOGTMP0001':                 // Log file
           'QTEMP':                      // Log library
           '*YES':                       // Recreate file
           '*NO');                       // Prompt the CL command

   // Write to log file, append to current log. No prompt
   rtncmd=QshWrtLog('''is is''ates''':   // Msg
           'INFO':                       // Msg type
           'LOGTMP0001':                 // Log file
           'QTEMP':                      // Log library
           '*NO':                        // Don't recreate file
           '*NO');                       // Prompt the CL command

   // Print the log file to an output queue
   rtncmd=QshPrtLog(
           'LOGTMP0001':                 // Log file
           'QTEMP':                      // Log library
           '*NONE':                      // IFS file or *NONE
           '*YES':                       // Replace IFS file
           'PRTLOG':                     // Log spool file name
           '*SAME':                      // Outq LIB/OUTQ or *SAME
           '*NO');                     // Prompt the command

   // Print the log file fo the IFS
   rtncmd=QshPrtLog(
           'LOGTMP0001':                 // Log file
           'QTEMP':                      // Log library
           '/tmp/prtlog.pdf':            // IFS file or *NONE
           '*YES':                       // Replace IFS file
           'PRTLOG':                     // Log spool file name
           '*SAME':                      // Outq LIB/OUTQ or *SAME
           '*NO');                     // Prompt the command

   // Exit the program now. We're done
   *inlr=*on;
   return;

