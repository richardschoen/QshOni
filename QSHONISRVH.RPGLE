**FREE

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
 Dcl-PR QshBash               Int(10:0);
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

