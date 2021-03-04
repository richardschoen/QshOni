/*------------------------------------------------------------*/
/* @@LIBRARY: QSHONI                                          */
/* @@FILE: SOURCE                                             */
/* @@MEMBER: SRCBLDC                                          */
/* @@TYPE: CLP                                                */
/* @@TEXT: Build  cmds from QSHONI/SOURCE file                */
/*------------------------------------------------------------*/
             PGM

             DCL        VAR(&DESTFILE) TYPE(*CHAR) LEN(10) +
                          VALUE(SOURCE)
             DCL        VAR(&DESTLIB) TYPE(*CHAR) LEN(10) +
                          VALUE(QSHONI)
             DCL        VAR(&TGTRLS) TYPE(*CHAR) LEN(10) +
                          VALUE(*CURRENT)
             DCL        VAR(&VERSION) TYPE(*CHAR) LEN(30) VALUE(V1.0.4)

 /* Add libraries to library list */
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

 /* Change library desc to match the version */
             CHGLIB     LIB(QSHONI) TEXT('QShell on IBM i -' |> +
                          &VERSION)

 /* Make /tmp/qsh dir */
             MKDIR      DIR('/tmp/qsh') DTAAUT(*RWX) OBJAUT(*ALL)
             MONMSG     MSGID(CPF0000)

             ENDPGM
