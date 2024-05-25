**FREE

Ctl-Opt NoMain;

//TODO:
// Retrieve error message and CPF ID on failure.

 Dcl-Ds *N psds;
   PROGID *PROC;
 End-Ds;

  //  Work fields
  Dcl-S qt                    Char(1) inz('''');
  Dcl-S clcmd              VarChar(5000) inz('');
  dcl-s rtncmd int(10);

 //  Run CL command line via QCMDEXC program call
 Dcl-PR QcmdExc                  Extpgm('QCMDEXC');
    *N                       Char(5000) Const Options(*Varsize);
    *N                     Packed(15:5) Const;
 End-PR;

 //  Run CL command via wrapper procedure
 //  that calls QCmdExc and monitors for errors.
 Dcl-PR RunClCmd              Int(10:0);
    *N                    VarChar(5000) const;
 End-PR;

 //  Run pase command via QSHEXEC command
 Dcl-PR QshExec               Int(10:0);
    cmdln                 VarChar(5000) const;
    setpkgpath            VarChar(4) const;
    dspstdout             VarChar(5) const;
    logstdout             VarChar(5) const;
    prtstdout             VarChar(5) const;
    dltstdout             VarChar(5) const;
    ifsstdout             VarChar(5) const;
    ifsfile               VarChar(255) const;
    ifsopt                VarChar(10) const;
    ccsid                 VarChar(10) const;
    prtsplf               VarChar(10) const;
    prtusrdta             VarChar(10) const;
    prttxt                VarChar(30) const;
    prthold               VarChar(4) const;
    prtoutq               VarChar(21) const;
    outfile               VarChar(21) const;
    mbropt                VarChar(10) const;
    pasejobnam            VarChar(10) const;
    promptcmd             VarChar(5) const;
 End-PR;

 //  Run pase command via QSHBASH CL command
 Dcl-PR QshbASH               Int(10:0);
    cmdln                 VarChar(5000) const;
    setpkgpath            VarChar(4) const;
    dspstdout             VarChar(5) const;
    logstdout             VarChar(5) const;
    prtstdout             VarChar(5) const;
    dltstdout             VarChar(5) const;
    ifsstdout             VarChar(5) const;
    ifsfile               VarChar(255) const;
    ifsopt                VarChar(10) const;
    ccsid                 VarChar(10) const;
    prtsplf               VarChar(10) const;
    prtusrdta             VarChar(10) const;
    prttxt                VarChar(30) const;
    prthold               VarChar(4) const;
    prtoutq               VarChar(21) const;
    outfile               VarChar(21) const;
    mbropt                VarChar(10) const;
    pasejobnam            VarChar(10) const;
    promptcmd             VarChar(5) const;
 End-PR;

 //  ------------------------------------------------------
 //  Proc: QshExec
 //  Desc: Run pase command via QSHONI/QSHEXEC command
 //  Parms:
 //  P1-cmdln - PASE/QSH command to run
 //  Returns:
 //  0=success, -2=errors
 //  ------------------------------------------------------
 Dcl-Proc QshExec export;
 Dcl-PI QshExec               Int(10:0);
    cmdln                 VarChar(5000) const;
    setpkgpath            VarChar(4) const;
    dspstdout             VarChar(5) const;
    logstdout             VarChar(5) const;
    prtstdout             VarChar(5) const;
    dltstdout             VarChar(5) const;
    ifsstdout             VarChar(5) const;
    ifsfile               VarChar(255) const;
    ifsopt                VarChar(10) const;
    ccsid                 VarChar(10) const;
    prtsplf               VarChar(10) const;
    prtusrdta             VarChar(10) const;
    prttxt                VarChar(30) const;
    prthold               VarChar(4) const;
    prtoutq               VarChar(21) const;
    outfile               VarChar(21) const;
    mbropt                VarChar(10) const;
    pasejobnam            VarChar(10) const;
    promptcmd             VarChar(5) const;
 End-PI;
 Dcl-S qshcmd             VarChar(5000) inz('');

    // Execute QSHEXEC CL command
    Monitor;

       // Set blank parm defaults

       // Build QSHEXEC command call
       qshcmd='QSHONI/QSHEXEC CMDLINE(' + qt + %trim(cmdln) + qt + ') ' +
               'SETPKGPATH(@@SETPKGPATH) ' +
               'DSPSTDOUT(@@DSPSTDOUT) ' +
               'LOGSTDOUT(@@LOGSTDOUT) ' +
               'PRTSTDOUT(@@PRTSTDOUT) ' +
               'DLTSTDOUT(@@DLTSTDOUT) ' +
               'IFSSTDOUT(@@IFSSTDOUT) ' +
               'IFSFILE(''@@IFSFILE'') ' +
               'IFSOPT(@@IFSOPT) ' +
               'CCSID(@@CCSID) ' +
               'PRTSPLF(@@PRTSPLF) ' +
               'PRTUSRDTA(*NONE) ' +
               'PRTTXT(*NONE) ' +
               'PRTHOLD(*YES) ' +
               'PRTOUTQ(*SAME) ' +
               'OUTFILE(QTEMP/STDOUTQSH) ' +
               'MBROPT(*REPLACE) ' +
               'PASEJOBNAM(@@PASEJOBNAM)';

        // Replace keywords with parm values
        qshcmd = %scanrpl('@@SETPKGPATH':%trim(setpkgpath):qshcmd);
        qshcmd = %scanrpl('@@DSPSTDOUT':%trim(dspstdout):qshcmd);
        qshcmd = %scanrpl('@@LOGSTDOUT':%trim(logstdout):qshcmd);
        qshcmd = %scanrpl('@@PRTSTDOUT':%trim(prtstdout):qshcmd);
        qshcmd = %scanrpl('@@DLTSTDOUT':%trim(dltstdout):qshcmd);
        qshcmd = %scanrpl('@@IFSSTDOUT':%trim(ifsstdout):qshcmd);
        qshcmd = %scanrpl('@@IFSFILE':%trim(ifsfile):qshcmd);
        qshcmd = %scanrpl('@@IFSOPT':%trim(ifsopt):qshcmd);
        qshcmd = %scanrpl('@@CCSID':%trim(ccsid):qshcmd);
        qshcmd = %scanrpl('@@PRTSPLF':%trim(prtsplf):qshcmd);
        qshcmd = %scanrpl('@@PRTUSRDTA':%trim(prtusrdta):qshcmd);
        qshcmd = %scanrpl('@@PRTTXT':%trim(prttxt):qshcmd);
        qshcmd = %scanrpl('@@PRTHOLD':%trim(prthold):qshcmd);
        qshcmd = %scanrpl('@@PRTOUTQ':%trim(prtoutq):qshcmd);
        qshcmd = %scanrpl('@@OUTFILE':%trim(outfile):qshcmd);
        qshcmd = %scanrpl('@@MBROPT':%trim(mbropt):qshcmd);
        qshcmd = %scanrpl('@@PASEJOBNAM':%trim(pasejobnam):qshcmd);

        // If promptcmd = *YES add ? to ptompt CL command
        if (%trim(promptcmd)='*YES');
           qshcmd = '? ' + qshcmd;
        endif;

       // Run CL command
       QcmdExc(%trim(qshcmd):%Len(qshcmd));

       Return 0;

    On-Error;
       Return -2;
    EndMon;

 End-Proc QshExec;

 //  ------------------------------------------------------
 //  Proc: QshBash
 //  Desc: Run pase command via QSHONI/QSHBASH command
 //  Parms:
 //  P1-cmdln - PASE/QSH command to run
 //  Returns:
 //  0=success, -2=errors
 //  ------------------------------------------------------
 Dcl-Proc QshBash export;
 Dcl-PI QshBash               Int(10:0);
    cmdln                 VarChar(5000) const;
    setpkgpath            VarChar(4) const;
    dspstdout             VarChar(5) const;
    logstdout             VarChar(5) const;
    prtstdout             VarChar(5) const;
    dltstdout             VarChar(5) const;
    ifsstdout             VarChar(5) const;
    ifsfile               VarChar(255) const;
    ifsopt                VarChar(10) const;
    ccsid                 VarChar(10) const;
    prtsplf               VarChar(10) const;
    prtusrdta             VarChar(10) const;
    prttxt                VarChar(30) const;
    prthold               VarChar(4) const;
    prtoutq               VarChar(21) const;
    outfile               VarChar(21) const;
    mbropt                VarChar(10) const;
    pasejobnam            VarChar(10) const;
    promptcmd             VarChar(5) const;
 End-PI;
 Dcl-S qshcmd             VarChar(5000) inz('');

    // Execute QSHBASH CL command
    Monitor;

       // Set blank parm defaults

       // Build QSHBASH command call
       qshcmd='QSHONI/QSHBASH CMDLINE(' + qt + %trim(cmdln) + qt + ') ' +
               'SETPKGPATH(@@SETPKGPATH) ' +
               'DSPSTDOUT(@@DSPSTDOUT) ' +
               'LOGSTDOUT(@@LOGSTDOUT) ' +
               'PRTSTDOUT(@@PRTSTDOUT) ' +
               'DLTSTDOUT(@@DLTSTDOUT) ' +
               'IFSSTDOUT(@@IFSSTDOUT) ' +
               'IFSFILE(''@@IFSFILE'') ' +
               'IFSOPT(@@IFSOPT) ' +
               'CCSID(@@CCSID) ' +
               'PRTSPLF(@@PRTSPLF) ' +
               'PRTUSRDTA(*NONE) ' +
               'PRTTXT(*NONE) ' +
               'PRTHOLD(*YES) ' +
               'PRTOUTQ(*SAME) ' +
               'OUTFILE(QTEMP/STDOUTQSH) ' +
               'MBROPT(*REPLACE) ' +
               'PASEJOBNAM(@@PASEJOBNAM)';

        // Replace keywords with parm values
        qshcmd = %scanrpl('@@SETPKGPATH':%trim(setpkgpath):qshcmd);
        qshcmd = %scanrpl('@@DSPSTDOUT':%trim(dspstdout):qshcmd);
        qshcmd = %scanrpl('@@LOGSTDOUT':%trim(logstdout):qshcmd);
        qshcmd = %scanrpl('@@PRTSTDOUT':%trim(prtstdout):qshcmd);
        qshcmd = %scanrpl('@@DLTSTDOUT':%trim(dltstdout):qshcmd);
        qshcmd = %scanrpl('@@IFSSTDOUT':%trim(ifsstdout):qshcmd);
        qshcmd = %scanrpl('@@IFSFILE':%trim(ifsfile):qshcmd);
        qshcmd = %scanrpl('@@IFSOPT':%trim(ifsopt):qshcmd);
        qshcmd = %scanrpl('@@CCSID':%trim(ccsid):qshcmd);
        qshcmd = %scanrpl('@@PRTSPLF':%trim(prtsplf):qshcmd);
        qshcmd = %scanrpl('@@PRTUSRDTA':%trim(prtusrdta):qshcmd);
        qshcmd = %scanrpl('@@PRTTXT':%trim(prttxt):qshcmd);
        qshcmd = %scanrpl('@@PRTHOLD':%trim(prthold):qshcmd);
        qshcmd = %scanrpl('@@PRTOUTQ':%trim(prtoutq):qshcmd);
        qshcmd = %scanrpl('@@OUTFILE':%trim(outfile):qshcmd);
        qshcmd = %scanrpl('@@MBROPT':%trim(mbropt):qshcmd);
        qshcmd = %scanrpl('@@PASEJOBNAM':%trim(pasejobnam):qshcmd);

        // If promptcmd = *YES add ? to ptompt CL command
        if (%trim(promptcmd)='*YES');
           qshcmd = '? ' + qshcmd;
        endif;

       // Run CL command
       QcmdExc(%trim(qshcmd):%Len(qshcmd));

       Return 0;

    On-Error;
       Return -2;
    EndMon;

 End-Proc QshBash;

 // ------------------------------------------------------
 //  Proc: RunClCmd
 //
 //  Desc: Run CL command line via QCMDEXEC
 //        Handles command line trimming internally.
 //
 //  Parms:
 //  P1-cmdln - Command line to run
 //
 //  Returns:
 //  0=success, -2=errors
 // ------------------------------------------------------
 Dcl-Proc RunClCmd export;
 Dcl-PI RunClCmd              Int(10:0);
    cmdln                 VarChar(5000) const;
 End-PI;
 Dcl-S lccmd              VarChar(5000) inz('');

    // Execute QSHEXEC CL command
    Monitor;

       // Set local command and run via QcmdExc;
       lccmd = cmdln;
       QcmdExc(%trim(lccmd):%Len(lccmd));

       // Ran successfully
       Return 0;

    On-Error;
       // Error occurred
       Return -2;
    EndMon;

 End-Proc RunClCmd;
