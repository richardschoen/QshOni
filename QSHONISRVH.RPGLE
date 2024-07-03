**FREE

 //  Run CL command line via QCMDEXC program call
 Dcl-PR QcmdExc                  Extpgm('QCMDEXC');
    *N                       Char(5000) Const Options(*Varsize);
    *N                     Packed(15:5) Const;
 End-PR;

 //  Run QSHGETPARR rpg program to get return values
 Dcl-PR QshGetParr               Extpgm('QSHGETPARR');
    parm01                 Char(255);
    parm02                 Char(255);
    parm03                 Char(255);
    parm04                 Char(255);
    parm05                 Char(255);
    parm06                 Char(255);
    parm07                 Char(255);
    parm08                 Char(255);
    parm09                 Char(255);
    parm10                 Char(255);
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

 //  Run pase command via QSHCALL CL command and return values
 Dcl-PR QshCall               Int(10:0);
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
    rtnparm01             Char(255);
    rtnparm02             Char(255);
    rtnparm03             Char(255);
    rtnparm04             Char(255);
    rtnparm05             Char(255);
    rtnparm06             Char(255);
    rtnparm07             Char(255);
    rtnparm08             Char(255);
    rtnparm09             Char(255);
    rtnparm10             Char(255);
 End-PR;

