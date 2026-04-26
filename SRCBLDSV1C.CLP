/* Rebuild Service Program */
             PGM

             DCL        VAR(&DESTFILE) TYPE(*CHAR) LEN(10) +
                          VALUE(SOURCE)
             DCL        VAR(&DESTLIB) TYPE(*CHAR) LEN(10) +
                          VALUE(QSHONI)
             DCL        VAR(&TGTRLS) TYPE(*CHAR) LEN(10) +
                          VALUE(*CURRENT)

 /** Add libraries to library list */
             ADDLIBLE   LIB(&DESTLIB)
             MONMSG     MSGID(CPF0000)

             CRTRPGMOD  MODULE(&DESTLIB/QSHONISRV) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          DBGVIEW(*SOURCE)

             CRTSRVPGM  SRVPGM(&DESTLIB/QSHONISRV) +
                          MODULE(&DESTLIB/QSHONISRV) +
                          EXPORT(*SRCFILE) SRCFILE(&DESTLIB/SOURCE) +
                          SRCMBR(QSHONISRVD) BNDSRVPGM(*NONE) +
                          BNDDIR(*NONE) ACTGRP(*CALLER)

             /* Delete binding directory */
             DLTBNDDIR  BNDDIR(&DESTLIB/QSHONISRV)
             MONMSG     MSGID(CPF0000)

             CRTBNDDIR  BNDDIR(&DESTLIB/QSHONISRV) TEXT('Binding +
                          Directory for QSHONISRV Service Program') +

             ADDBNDDIRE BNDDIR(&DESTLIB/QSHONISRV) +
                          OBJ((&DESTLIB/QSHONISRV *SRVPGM *IMMED)) +
                          POSITION(*LAST)

             ENDPGM
