             PGM

             DCL        VAR(&DESTFILE) TYPE(*CHAR) LEN(10) +
                          VALUE(SOURCE)
             DCL        VAR(&DESTLIB) TYPE(*CHAR) LEN(10) +
                          VALUE(QSHONI)
             DCL        VAR(&TGTRLS) TYPE(*CHAR) LEN(10) +
                          VALUE(*CURRENT)
             DCL        VAR(&VERSION) TYPE(*CHAR) LEN(30) +
                          VALUE(V1.0.25)
             DCL        VAR(&QSHPYTHON) TYPE(*CHAR) LEN(255)
             DCL        VAR(&CMD) TYPE(*CHAR) LEN(512)
             DCL        VAR(&LEN) TYPE(*DEC) LEN(15 5)

 /** Add libraries to library list */
             ADDLIBLE   LIB(&DESTLIB)
             MONMSG     MSGID(CPF0000)

             CRTCMD     CMD(&DESTLIB/QSHPATH) PGM(QSHPATHC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB)

             CRTCLPGM   PGM(&DESTLIB/QSHPATHC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS)

             CRTCMD     CMD(&DESTLIB/QSHEXEC) PGM(QSHEXECC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB)

             CRTCLPGM   PGM(&DESTLIB/QSHEXECC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS)

             CRTBNDRPG  PGM(&DESTLIB/QSHSTDOUTR) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*NO) REPLACE(*NO) TGTRLS(&TGTRLS)

             CRTCMD     CMD(&DESTLIB/QSHLOGSCAN) PGM(QSHLOGSCAC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB)

             CRTCLPGM   PGM(&DESTLIB/QSHLOGSCAC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS)

             CRTBNDRPG  PGM(&DESTLIB/QSHLOGSCAR) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DFTACTGRP(*NO) REPLACE(*NO) TGTRLS(&TGTRLS)

             CRTCMD     CMD(&DESTLIB/QSHBASH) PGM(QSHBASHC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* V1.0.3 */

             CRTCLPGM   PGM(&DESTLIB/QSHBASHC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* V1.0.3 */

             /* 1.05 - ADD IFS CHECK AND QSHPYRUN */
             CRTCMD     CMD(&DESTLIB/QSHIFSCHK) PGM(QSHIFSCHKC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB)

             CRTCLPGM   PGM(&DESTLIB/QSHIFSCHKC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHIFSCHKC) REPLACE(*NO) +
                          TGTRLS(&TGTRLS)

             CRTBNDRPG  PGM(&DESTLIB/QSHIFSCHKR) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHIFSCHKR) DFTACTGRP(*NO) +
                          REPLACE(*NO) TGTRLS(&TGTRLS)

             CRTCMD     CMD(&DESTLIB/QSHPYRUN) PGM(QSHPYRUNC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* V1.0.5 */

             CRTCLPGM   PGM(&DESTLIB/QSHPYRUNC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* V1.0.5 */

             CRTCMD     CMD(&DESTLIB/QSHPHPRUN) PGM(QSHPHPRUNC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* V1.0.24 */

             CRTCLPGM   PGM(&DESTLIB/QSHPHPRUNC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* V1.0.24 */

             CRTCMD     CMD(&DESTLIB/QSHQRYTMP) PGM(QSHQRYTMPC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* V1.0.8 */

             CRTCLPGM   PGM(&DESTLIB/QSHQRYTMPC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* V1.0.8 */

             CRTCMD     CMD(&DESTLIB/QSHSETPROF) PGM(QSHSETPROC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* V1.0.11 */

             CRTCLPGM   PGM(&DESTLIB/QSHSETPROC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* V1.0.11 */

             CRTCMD     CMD(&DESTLIB/QSHCURL) PGM(QSHCURLC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* V1.0.12 */

             CRTCLPGM   PGM(&DESTLIB/QSHCURLC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* V1.0.12 */

             CRTCMD     CMD(&DESTLIB/QSHPORTCHK) PGM(QSHPORTCHC) +
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

             CRTCMD     CMD(&DESTLIB/QSHPORTEND) PGM(QSHPORTENC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) /* V1.0.14 */

             CRTCLPGM   PGM(&DESTLIB/QSHPORTENC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* V1.0.14 */

             CRTCMD     CMD(&DESTLIB/QSHEXECSRC) PGM(QSHEXECSCC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB) /* 1.0.18 */

             CRTCLPGM   PGM(&DESTLIB/QSHEXECSCC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.18 */

             CRTCMD     CMD(&DESTLIB/DB2UTIL) PGM(DB2UTILC) +
                          SRCFILE(&DESTLIB/&DESTFILE) PRDLIB(&DESTLIB) /* 1.0.23 */

             CRTCLPGM   PGM(&DESTLIB/DB2UTILC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.23 */

             CRTCMD     CMD(&DESTLIB/QSHGETPARM) PGM(QSHGETPARR) +
                          SRCFILE(&DESTLIB/&DESTFILE) ALLOW(*IPGM +
                          *BPGM *IMOD *BMOD) PRDLIB(&DESTLIB) /* +
                          1.0.25 */

             CRTBNDRPG  PGM(&DESTLIB/QSHGETPARR) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          SRCMBR(QSHGETPARR) DFTACTGRP(*NO) +
                          REPLACE(*NO) TGTRLS(&TGTRLS) /* 1.0.25 */

             CRTCMD     CMD(&DESTLIB/QSHPYCALL) PGM(QSHPYCALLC) +
                          SRCFILE(&DESTLIB/&DESTFILE) ALLOW(*IPGM +
                          *BPGM *IMOD *BMOD) PRDLIB(&DESTLIB) /* +
                          1.0.25 */

             CRTCLPGM   PGM(&DESTLIB/QSHPYCALLC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.25 */

             CRTCLPGM   PGM(&DESTLIB/QSHPYCALLT) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.25 */

             CRTCMD     CMD(&DESTLIB/QSHCALL) PGM(QSHCALLC) +
                          SRCFILE(&DESTLIB/&DESTFILE) ALLOW(*IPGM +
                          *BPGM *IMOD *BMOD) PRDLIB(&DESTLIB) /* +
                          1.0.25 */

             CRTCLPGM   PGM(&DESTLIB/QSHCALLC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.25 */

             CRTCLPGM   PGM(&DESTLIB/QSHCALLT) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*NO) +
                          TGTRLS(&TGTRLS) /* 1.0.25 */

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

 /* Change library desc to match the version */
             CHGLIB     LIB(QSHONI) TEXT('QShell on IBM i -' |> +
                          &VERSION)

 /* Make /tmp/qsh dir */
             MKDIR      DIR('/tmp/qsh') DTAAUT(*RWX) OBJAUT(*ALL)
             MONMSG     MSGID(CPF0000)

             ENDPGM
