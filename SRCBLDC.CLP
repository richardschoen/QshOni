             PGM

             DCL        VAR(&DESTFILE) TYPE(*CHAR) LEN(10) +
                          VALUE(SOURCE)
             DCL        VAR(&DESTLIB) TYPE(*CHAR) LEN(10) +
                          VALUE(QSHONI)
             DCL        VAR(&TGTRLS) TYPE(*CHAR) LEN(10) +
                          VALUE(V7R3M0)
             DCL        VAR(&VERSION) TYPE(*CHAR) LEN(30) +
                          VALUE(V1.0.58)
             DCL        VAR(&QSHPYTHON) TYPE(*CHAR) LEN(255)
             DCL        VAR(&CMD) TYPE(*CHAR) LEN(512)
             DCL        VAR(&LEN) TYPE(*DEC) LEN(15 5)

 /** Add libraries to library list */
             ADDLIBLE   LIB(&DESTLIB)
             MONMSG     MSGID(CPF0000)

             /* Create temporary source file - 1.0.36 */
             DLTF   FILE(QTEMP/TMPQRYSRC)
             MONMSG     MSGID(CPF0000)
             CRTSRCPF   FILE(QTEMP/TMPQRYSRC) RCDLEN(240)
             MONMSG     MSGID(CPF0000)

             CRTPNLGRP PNLGRP(QSHONI/QSHONICMDS) +
                 SRCFILE(QSHONI/SOURCE) +
                 SRCMBR(QSHONICMDS) +
                 REPLACE(*NO) /* 1.0.40 */

             CRTCMD     CMD(&DESTLIB/QSHPATH) PGM(&DESTLIB/QSHPATHC) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHPATH) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB)

             CRTCLPGM   PGM(&DESTLIB/QSHPATHC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS)

             CRTCMD     CMD(&DESTLIB/QSHEXEC) PGM(&DESTLIB/QSHEXECC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHEXEC) /* V1.0.40 */

             CRTCLPGM   PGM(&DESTLIB/QSHEXECC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS)

             CRTBNDRPG  PGM(&DESTLIB/QSHSTDOUTR) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*NO) REPLACE(*NO) TGTRLS(&TGTRLS)

             CRTCMD     CMD(&DESTLIB/QSHLOGSCAN) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHLOGSCAN) +
                          PGM(&DESTLIB/QSHLOGSCAC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB)

             CRTCLPGM   PGM(&DESTLIB/QSHLOGSCAC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS)

             CRTBNDRPG  PGM(&DESTLIB/QSHLOGSCAR) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*NO) REPLACE(*NO) TGTRLS(&TGTRLS)

             CRTCMD     CMD(&DESTLIB/QSHBASH) PGM(&DESTLIB/QSHBASHC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHBASH) +
                          PRDLIB(&DESTLIB) /* V1.0.3-V1.0.40 */

             CRTCLPGM   PGM(&DESTLIB/QSHBASHC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* V1.0.3 */

             /* 1.05 - ADD IFS CHECK AND QSHPYRUN */
             CRTCMD     CMD(&DESTLIB/QSHIFSCHK) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHIFSCHK) +
                          PGM(&DESTLIB/QSHIFSCHKC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB)

             CRTCLPGM   PGM(&DESTLIB/QSHIFSCHKC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHIFSCHKC) REPLACE(*NO) +
                          TGTRLS(&TGTRLS)

             CRTBNDRPG  PGM(&DESTLIB/QSHIFSCHKR) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHIFSCHKR) DFTACTGRP(*NO) +
                          REPLACE(*NO) TGTRLS(&TGTRLS)

             CRTCMD     CMD(&DESTLIB/QSHPYRUN) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHPYRUN) +
                          PGM(&DESTLIB/QSHPYRUNC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* V1.0.5 */

             CRTCLPGM   PGM(&DESTLIB/QSHPYRUNC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* V1.0.5 */

             CRTCMD     CMD(&DESTLIB/QSHPHPRUN) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHPHPRUN) +
                          PGM(&DESTLIB/QSHPHPRUNC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* V1.0.24 */

             CRTCLPGM   PGM(&DESTLIB/QSHPHPRUNC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* V1.0.24 */

             CRTCMD     CMD(&DESTLIB/QSHQRYAID) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHQRYAID) +
                          PGM(&DESTLIB/QSHQRYAIDC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* V1.0.36 */

             CRTCLPGM   PGM(&DESTLIB/QSHQRYAIDC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* V1.0.36 */

             CRTCMD     CMD(&DESTLIB/QSHQRYTMP) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHQRYTMP) +
                          PGM(&DESTLIB/QSHQRYTMPC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* V1.0.8 */

             CRTCLPGM   PGM(&DESTLIB/QSHQRYTMPC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* V1.0.8 */

             CRTBNDRPG  PGM(&DESTLIB/QSHQRYTMPR) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHQRYTMPR) DFTACTGRP(*NO) +
                          REPLACE(*NO) TGTRLS(&TGTRLS)  /* 1.0.36 */

             CRTCMD     CMD(&DESTLIB/QSHSETPROF) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHSETPROF) +
                          PGM(&DESTLIB/QSHSETPROC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* V1.0.11 */

             CRTCLPGM   PGM(&DESTLIB/QSHSETPROC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* V1.0.11 */

             CRTCMD     CMD(&DESTLIB/QSHCURL) PGM(&DESTLIB/QSHCURLC) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHCURL) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* V1.0.12 */

             CRTCLPGM   PGM(&DESTLIB/QSHCURLC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* V1.0.12 */

             CRTCMD     CMD(&DESTLIB/QSHPORTCHK) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHPORTCHK) +
                          PGM(&DESTLIB/QSHPORTCHC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* V1.0.13 */

             CRTCLPGM   PGM(&DESTLIB/QSHPORTCHC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* V1.0.13 */

  /*         QSHQRYTMP  SQL('SELECT JOB_NAME FROM +                       */
  /*                      QSYS2.NETSTAT_JOB_INFO') +                      */
  /*                      OUTFILE(QTEMP/TCPTMPEND)    V1.0.14 */


             CHGVAR     VAR(&CMD) VALUE('QSHQRYTMP SQL(''SELECT +
                          JOB_NAME FROM QSYS2.NETSTAT_JOB_INFO'') +
                          OUTFILE(QTEMP/TCPTMPEND)') /* V1.0.14 */
             CHGVAR     VAR(&LEN) VALUE(85)
             CALL       PGM(QCMDEXC) PARM(&CMD &LEN) /* V1.0.14 */

             CRTCMD     CMD(&DESTLIB/QSHPORTEND) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHPORTEND) +
                          PGM(&DESTLIB/QSHPORTENC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* V1.0.14 */

             CRTCLPGM   PGM(&DESTLIB/QSHPORTENC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* V1.0.14 */

             CRTCMD     CMD(&DESTLIB/QSHEXECSRC) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHEXECSRC) +
                          PGM(&DESTLIB/QSHEXECSCC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* 1.0.18 */

             CRTCLPGM   PGM(&DESTLIB/QSHEXECSCC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.18 */

             CRTCMD     CMD(&DESTLIB/DB2UTIL) PGM(&DESTLIB/DB2UTILC) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(DB2UTIL) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* 1.0.23 */

             CRTCLPGM   PGM(&DESTLIB/DB2UTILC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.23 */

             CRTCMD     CMD(&DESTLIB/QSHGETPARM) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHGETPARM) +
                          PGM(&DESTLIB/QSHGETPARR) +
                          SRCFILE(&DESTLIB/&DESTFILE) ALLOW(*IPGM +
                          *BPGM *IMOD *BMOD) PRDLIB(&DESTLIB) /* +
                          1.0.25 */

             CRTBNDRPG  PGM(&DESTLIB/QSHGETPARR) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHGETPARR) DFTACTGRP(*NO) +
                          REPLACE(*NO) TGTRLS(&TGTRLS) /* 1.0.25 */

             CRTCMD     CMD(&DESTLIB/QSHGETPR2) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHGETPR2) +
                          PGM(&DESTLIB/QSHGETPR2C) +
                          SRCFILE(&DESTLIB/&DESTFILE) ALLOW(*IPGM +
                          *BPGM *IMOD *BMOD) PRDLIB(&DESTLIB) /* +
                          1.0.37 */

             CRTBNDCL   PGM(&DESTLIB/QSHGETPR2C) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*YES) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.37 */

             CRTCMD     CMD(&DESTLIB/QSHPYCALL) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHPYCALL) +
                          PGM(&DESTLIB/QSHPYCALLC) +
                          SRCFILE(&DESTLIB/&DESTFILE) ALLOW(*IPGM +
                          *BPGM *IMOD *BMOD) PRDLIB(&DESTLIB) /* +
                          1.0.25 */

             CRTCLPGM   PGM(&DESTLIB/QSHPYCALLC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.25 */

             CRTCLPGM   PGM(&DESTLIB/QSHPYCALLT) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.25 */

             CRTCMD     CMD(&DESTLIB/QSHCALL) PGM(&DESTLIB/QSHCALLC) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHCALL) +
                          SRCFILE(&DESTLIB/&DESTFILE) ALLOW(*IPGM +
                          *BPGM *IMOD *BMOD) PRDLIB(&DESTLIB) /* +
                          1.0.25 */

             CRTCLPGM   PGM(&DESTLIB/QSHCALLC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.25 */

             CRTCLPGM   PGM(&DESTLIB/QSHCALLT) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.25 */

             CRTCMD     CMD(&DESTLIB/QSHCPYSRC) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHCPYSRC) +
                          PGM(&DESTLIB/QSHCPYSRCC) +
                          SRCFILE(&DESTLIB/&DESTFILE) ALLOW(*IPGM +
                          *BPGM *IMOD *BMOD) PRDLIB(&DESTLIB) /* +
                          1.0.26 */

             CRTCLPGM   PGM(&DESTLIB/QSHCPYSRCC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.26 */

             CRTCMD     CMD(&DESTLIB/QSHSRCIFS) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHSRCIFS) +
                          PGM(&DESTLIB/QSHSRCIFSC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB)

             CRTBNDCL   PGM(&DESTLIB/QSHSRCIFSC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*YES) REPLACE(*NO) +
                          TGTRLS(&TGTRLS)

             CRTCMD     CMD(&DESTLIB/QSHBASHSRC) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHBASHSRC) +
                          PGM(&DESTLIB/QSHBASHSCC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* 1.0.27 */

             CRTCLPGM   PGM(&DESTLIB/QSHBASHSCC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.27 */

             CRTRPGMOD  MODULE(&DESTLIB/QSHONISRV) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          TGTRLS(&TGTRLS) +
                          DBGVIEW(*SOURCE) /* 1.0.28 */

             CRTSRVPGM  SRVPGM(&DESTLIB/QSHONISRV) +
                          MODULE(&DESTLIB/QSHONISRV) +
                          EXPORT(*SRCFILE) SRCFILE(&DESTLIB/SOURCE) +
                          SRCMBR(QSHONISRVD) BNDSRVPGM(*NONE) +
                          TGTRLS(&TGTRLS) +
                          BNDDIR(*NONE) ACTGRP(*CALLER) /* 1.0.29 */

             CRTBNDDIR  BNDDIR(&DESTLIB/QSHONISRV) TEXT('Binding +
                          Directory for QSHONISRV Service Program') +
                          /* 1.0.28 */

             ADDBNDDIRE BNDDIR(&DESTLIB/QSHONISRV) +
                          OBJ((&DESTLIB/QSHONISRV *SRVPGM *IMMED)) +
                          POSITION(*LAST) /* 1.0.28 */

             CRTBNDRPG  PGM(&DESTLIB/QSHONIPR01) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHONIPR01) DFTACTGRP(*NO) +
                          REPLACE(*NO) TGTRLS(&TGTRLS) /* 1.0.28 */

             CRTBNDRPG  PGM(&DESTLIB/QSHONIPR02) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHONIPR02) DFTACTGRP(*NO) +
                          REPLACE(*NO) TGTRLS(&TGTRLS) /* 1.0.28 */

             CRTBNDRPG  PGM(&DESTLIB/QSHONIPR03) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHONIPR03) DFTACTGRP(*NO) +
                          REPLACE(*NO) TGTRLS(&TGTRLS) /* 1.0.29 */

             CRTBNDRPG  PGM(&DESTLIB/QSHONIPR04) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHONIPR04) DFTACTGRP(*NO) +
                          REPLACE(*NO) TGTRLS(&TGTRLS) /* 1.0.47 */

             CRTCMD     CMD(&DESTLIB/QSHIFSSIZ) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHIFSSIZ) +
                          PGM(&DESTLIB/QSHIFSSIZC) +
                          SRCFILE(&DESTLIB/&DESTFILE) ALLOW(*IPGM +
                          *IMOD *BMOD *BPGM) PRDLIB(&DESTLIB) /* +
                          1.0.30 */

             CRTBNDCL   PGM(&DESTLIB/QSHIFSSIZC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*YES) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.30 */

             CRTCMD     CMD(&DESTLIB/QSHSAVLIB) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHSAVLIB) +
                          PGM(&DESTLIB/QSHSAVLIBC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* 1.0.32 */

             CRTCLPGM   PGM(&DESTLIB/QSHSAVLIBC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.32 */

             CRTCMD     CMD(&DESTLIB/QSHSAVIFS) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHSAVIFS) +
                          PGM(&DESTLIB/QSHSAVIFSC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* 1.0.32 */

             CRTCLPGM   PGM(&DESTLIB/QSHSAVIFSC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.32 */

             CRTCMD     CMD(&DESTLIB/QSHQRYSRC) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHQRYSRC) +
                          PGM(&DESTLIB/QSHQRYSRCC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* 1.0.32 */

             CRTCLPGM   PGM(&DESTLIB/QSHQRYSRCC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.32 */

             CRTBNDRPG  PGM(&DESTLIB/QSHQRYSRCR) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHQRYSRCR) DFTACTGRP(*NO) +
                          REPLACE(*NO) TGTRLS(&TGTRLS) /* 1.0.32 */

             CRTBNDRPG  PGM(&DESTLIB/QSHQRYSR2R) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHQRYSR2R) DFTACTGRP(*NO) +
                          REPLACE(*NO) TGTRLS(&TGTRLS)  /* 1.0.36 */

             CRTBNDRPG  PGM(&DESTLIB/QSHQRYSR3R) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHQRYSR3R) DFTACTGRP(*NO) +
                          REPLACE(*NO) TGTRLS(&TGTRLS)  /* 1.0.42 */

              CRTCMD     CMD(&DESTLIB/QSHIFSSCAN) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHIFSSCAN) +
                          PGM(&DESTLIB/QSHIFSSCAC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB) /* V1.0.35 */

             CRTCLPGM   PGM(&DESTLIB/QSHIFSSCAC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS)  /* V1.0.35 */

             CRTBNDRPG  PGM(&DESTLIB/QSHIFSSCAR) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*NO) REPLACE(*NO) TGTRLS(&TGTRLS)  /* V1.0.35 */

             CRTCMD     CMD(&DESTLIB/RUNSQLPRM) PGM(&DESTLIB/RUNSQLPRMC) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(RUNSQLPRM) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB) /* 1.0.36 */

             CRTCLPGM     PGM(&DESTLIB/RUNSQLPRMC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS)  /* 1.0.36 */

             CRTBNDRPG  PGM(&DESTLIB/RUNSQLPRMR) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*NO) REPLACE(*NO) TGTRLS(&TGTRLS)  /* 1.0.36 */

             CRTCMD     CMD(&DESTLIB/RUNSQLSRC) PGM(&DESTLIB/RUNSQLSRCC) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(RUNSQLSRC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB) /* 1.0.36 */

             CRTCLPGM     PGM(&DESTLIB/RUNSQLSRCC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.36 */

             CRTBNDRPG  PGM(&DESTLIB/RUNSQLSRCR) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*NO) REPLACE(*NO) TGTRLS(&TGTRLS)  /* 1.0.36 */

             CRTBNDRPG  PGM(&DESTLIB/RUNSQLSR3R) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*NO) REPLACE(*NO) TGTRLS(&TGTRLS)  /* 1.0.42 */

              CRTCMD     CMD(&DESTLIB/QSHJOBLIST) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHJOBLIST) +
                          PGM(&DESTLIB/QSHJOBLISC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB) /* +
                          1.0.44 */

             CRTBNDCL   PGM(&DESTLIB/QSHJOBLISC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*YES) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.44 */

              CRTCMD     CMD(&DESTLIB/QSHJOBACT) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHJOBACT) +
                          PGM(&DESTLIB/QSHJOBACTC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB) /* +
                          1.0.44 */

             CRTBNDCL   PGM(&DESTLIB/QSHJOBACTC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*YES) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.44 */

              CRTCMD     CMD(&DESTLIB/QSHENDWEB) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHENDWEB) +
                          PGM(&DESTLIB/QSHENDWEBC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB) /* +
                          1.0.45 */

             CRTBNDCL   PGM(&DESTLIB/QSHENDWEBC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*YES) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.45 */

              CRTCMD     CMD(&DESTLIB/QSHSCP) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHSCP) +
                          PGM(&DESTLIB/QSHSCPC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB) /* +
                          1.0.46 */

             CRTBNDCL   PGM(&DESTLIB/QSHSCPC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*YES) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.46 */

             CRTCMD     CMD(&DESTLIB/QSHWRTLOG) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHWRTLOG) +
                          PGM(&DESTLIB/QSHWRTLOGC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB) /* +
                          1.0.47 */

             CRTBNDCL   PGM(&DESTLIB/QSHWRTLOGC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*YES) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.47 */

             CRTBNDRPG  PGM(&DESTLIB/QSHWRTLOGR) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHWRTLOGR) DFTACTGRP(*NO) +
                          REPLACE(*NO) TGTRLS(&TGTRLS) /* 1.0.47 */

             CRTCMD     CMD(&DESTLIB/QSHPRTLOG) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHPRTLOG) +
                          PGM(&DESTLIB/QSHPRTLOGC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB) /* +
                          1.0.47 */

             CRTBNDCL   PGM(&DESTLIB/QSHPRTLOGC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*YES) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.47 */

             CRTCMD     CMD(&DESTLIB/QSHSAVOBJ) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHSAVOBJ) +
                          PGM(&DESTLIB/QSHSAVOBJC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB) /* +
                          1.0.50 */

             CRTBNDCL   PGM(&DESTLIB/QSHSAVOBJC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*YES) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.50 */

             CRTCMD     CMD(&DESTLIB/QSHSAVCHG) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHSAVCHG) +
                          PGM(&DESTLIB/QSHSAVCHGC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB) /* +
                          1.0.54 */

             CRTBNDCL   PGM(&DESTLIB/QSHSAVCHGC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*YES) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.54 */

             CRTCMD     CMD(&DESTLIB/QSHRSTLIB) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHRSTLIB) +
                          PGM(&DESTLIB/QSHRSTLIBC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB) /* +
                          1.0.50 */

             CRTBNDCL   PGM(&DESTLIB/QSHRSTLIBC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*YES) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.50 */

             CRTCMD     CMD(&DESTLIB/QSHRSTOBJ) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHRSTOBJ) +
                          PGM(&DESTLIB/QSHRSTOBJC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB) /* +
                          1.0.50 */

             CRTBNDCL   PGM(&DESTLIB/QSHRSTOBJC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*YES) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.50 */

             CRTCMD     CMD(&DESTLIB/QSHRSTIFS) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHRSTIFS) +
                          PGM(&DESTLIB/QSHRSTIFSC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB) /* +
                          1.0.50 */

             CRTBNDCL   PGM(&DESTLIB/QSHRSTIFSC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*YES) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.50 */

             CRTCMD     CMD(&DESTLIB/QSHVFYSAVF) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHVFYSAVF) +
                          PGM(&DESTLIB/QSHVFYSAVC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB) /* +
                          1.0.50 */

             CRTBNDCL   PGM(&DESTLIB/QSHVFYSAVC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*YES) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.50 */

             /* V1.0.51 */
             CRTCMD     CMD(&DESTLIB/QSHHOME) PGM(QSHHOMEC) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHHOME) +
                          SRCFILE(&DESTLIB/&DESTFILE) ALLOW(*BPGM +
                          *IPGM *BMOD *IMOD *BREXX *IREXX) +
                          PRDLIB(&DESTLIB)

             /* V1.0.51 */
             CRTBNDCL   PGM(&DESTLIB/QSHHOMEC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHHOMEC) DFTACTGRP(*NO) +
                          ALWRTVSRC(*NO) REPLACE(*NO) TGTRLS(&TGTRLS)

             /* V1.0.51 */
             CRTCMD     CMD(&DESTLIB/WRKIFSLIST) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(WRKIFSLIST) +
                          PGM(&DESTLIB/WRKIFSLISC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB)

             /* V1.0.51 */
             CRTBNDCL   PGM(&DESTLIB/WRKIFSCMD)  +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(WRKIFSCMD) +
                          ALWRTVSRC(*NO) REPLACE(*NO) TGTRLS(&TGTRLS)

             /* V1.0.51 */
             CRTBNDCL   PGM(&DESTLIB/WRKIFSLISC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(WRKIFSLISC) +
                          ALWRTVSRC(*NO) REPLACE(*NO) TGTRLS(&TGTRLS)

             /* V1.0.51 */
             CRTBNDCL   PGM(&DESTLIB/QSHGETHOME) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHGETHOME) +
                          ALWRTVSRC(*NO) REPLACE(*NO) TGTRLS(&TGTRLS)

             /* V1.0.51 */
             CRTDSPF    FILE(&DESTLIB/WRKIFSLISD) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO)

             /* V1.0.51 */
             CRTSQLRPGI OBJ(&DESTLIB/WRKIFSLISR) +
                          SRCFILE(&DESTLIB/&DESTFILE) SRCMBR(*OBJ) +
                          COMMIT(*NONE) OBJTYPE(*PGM) +
                          TGTRLS(&TGTRLS) +
                          CLOSQLCSR(*ENDMOD) REPLACE(*NO)

             /* V1.0.56 */
             CRTCMD     CMD(&DESTLIB/QSHLFTP) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHLFTP) +
                          PGM(&DESTLIB/QSHLFTPC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB)

             /* V1.0.56 */
             CRTBNDCL   PGM(&DESTLIB/QSHLFTPC)  +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHLFTPC) +
                          ALWRTVSRC(*NO) REPLACE(*NO) TGTRLS(&TGTRLS)

             /* V1.0.57 */
             CRTCMD     CMD(&DESTLIB/QSHSSH) +
                          HLPPNLGRP(QSHONI/QSHONICMDS) +
                          HLPID(QSHSSH) +
                          PGM(&DESTLIB/QSHSSHC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB)

             /* V1.0.57 */
             CRTBNDCL   PGM(&DESTLIB/QSHSSHC)  +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHSSHC) +
                          ALWRTVSRC(*NO) REPLACE(*NO) TGTRLS(&TGTRLS)

/* Create message file for any custom CPF messages */
 /* Initial use case is to log STDOUT msgs with own CPF ID    */
             CRTMSGF    MSGF(&DESTLIB/QSHMSG) TEXT('Qshell CPF +
                          Messages')

 /* General CPF message for joblog                  */
             ADDMSGD    MSGID(QSS9898) MSGF(&DESTLIB/QSHMSG) +
                          MSG('&1.') SECLVL('This message is used +
                          to log QSH console feedback messages.') +
                          FMT((*CHAR 512)) CCSID(*JOB)

 /* Create and set data area for version                      */
             CRTDTAARA  DTAARA(&DESTLIB/VERSION) TYPE(*CHAR) LEN(30) +
                          VALUE(&VERSION) TEXT(&DESTLIB |> 'version')
             MONMSG     MSGID(CPF0000)
             CHGDTAARA  DTAARA(&DESTLIB/VERSION *ALL) VALUE(&VERSION)

 /* Create and set data area for Python binary location - 1.05 */
             CRTDTAARA  DTAARA(QSHONI/PYPATH) TYPE(*CHAR) LEN(255) +
                          VALUE('/QOpenSys/pkgs/bin') TEXT('Path to +
                          Python Binaries')

 /* Create and set data area for Python binary location - 1.0.25 */
             CHGVAR     VAR(&QSHPYTHON) VALUE('/qshpython')
             CRTDTAARA  DTAARA(QSHONI/QSHPYTHON) TYPE(*CHAR) +
                          LEN(255) VALUE(&QSHPYTHON) TEXT('Path to +
                          QSHONI Python Scripts')

/* Attempt to create python script directory - V1.0.25 */
             MKDIR      DIR(&QSHPYTHON) DTAAUT(*RWX) OBJAUT(*ALL)
             MONMSG     MSGID(CPF0000)

 /* Create and set data area for PHP binary location - 1.0.24 */
             CRTDTAARA  DTAARA(QSHONI/PHPPATH) TYPE(*CHAR) LEN(255) +
                          VALUE(' ') TEXT('Path to PHP Binaries')

 /* Create and set data area for open source path loc - 1.0.9 */
             CRTDTAARA  DTAARA(QSHONI/QSHPATHLOC) TYPE(*CHAR) +
                          LEN(10) VALUE('*BEGIN') TEXT('Path +
                          position for open source packages')

 /* Create and set data area for dft IFS save file loc - 1.31 */
             CRTDTAARA  DTAARA(QSHONI/SAVFDIR) TYPE(*CHAR) LEN(255) +
                          VALUE('/tmp/savfqsh') TEXT('Path to save +
                          file IFS output')

 /* Make /tmp/savf dir - 1.31 */
             MKDIR      DIR('/tmp/savfqsh') DTAAUT(*RWX) OBJAUT(*ALL)
             MONMSG     MSGID(CPF0000)

 /* Change library desc to match the version */
             CHGLIB     LIB(QSHONI) TEXT('QShell on IBM i -' |> +
                          &VERSION)

             CRTLIB     LIB(QSHONITMP) TEXT('Qshoni Temp File +
                          Library') AUT(*ALL)
             MONMSG     MSGID(CPF0000)

 /* Make /tmp/qsh dir */
             MKDIR      DIR('/tmp/qsh') DTAAUT(*RWX) OBJAUT(*ALL)
             MONMSG     MSGID(CPF0000)

             ENDPGM
