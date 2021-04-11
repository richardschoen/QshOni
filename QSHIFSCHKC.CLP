             PGM        PARM(&IFSFILE)

             DCL        VAR(&RTNVAL) TYPE(*CHAR) LEN(6)
             DCL        VAR(&QTIME) TYPE(*CHAR) LEN(8)
             DCL        VAR(&TOMEMBER) TYPE(*CHAR) LEN(10)
             DCL        VAR(&FILE) TYPE(*CHAR) LEN(10)
             DCL        VAR(&JOBNAM) TYPE(*CHAR) LEN(10)
             DCL        VAR(&USER) TYPE(*CHAR) LEN(10)
             DCL        VAR(&FULLJOB) TYPE(*CHAR) LEN(26)
             DCL        VAR(&JOBNBR) TYPE(*CHAR) LEN(6)
             DCL        VAR(&SPLNBR) TYPE(*DEC) LEN(4 0)
             DCL        VAR(&SPLNBRC) TYPE(*CHAR) LEN(22)
             DCL        VAR(&CTLCHAR) TYPE(*CHAR) LEN(7)
             DCL        VAR(&JOBTYPE) TYPE(*CHAR) LEN(1)
             DCL        VAR(&IFSFILE) TYPE(*CHAR) LEN(255)
             DCL        VAR(&IFSFILE2) TYPE(*CHAR) LEN(255)
             DCL        VAR(&RTNERROR) TYPE(*DEC) LEN(5 0)
             DCL        VAR(&RTNERRORC) TYPE(*CHAR) LEN(5)

             DCL        &ERRORSW *LGL                     /* Std err */
             DCL        &MSGID *CHAR LEN(7)               /* Std err */
             DCL        &MSGDTA *CHAR LEN(100)            /* Std err */
             DCL        &MSGF *CHAR LEN(10)               /* Std err */
             DCL        &MSGFLIB *CHAR LEN(10)            /* Std err */
             DCL        &TXT1ST *CHAR LEN(100)           /* Std err */
             DCL        &TXT2ND *CHAR LEN(100)           /* Std err */
             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS)) /* +
                          Std err */

 /* CALL RPG PROGRAM TO CHECK FOR IFS FILE                      */
             CHGVAR     VAR(&IFSFILE2) VALUE(&IFSFILE)
             CALL       PGM(QSHIFSCHKR) PARM(&IFSFILE &RTNERROR)

/* IF ERRORS OCCUR DURING COPY, LOG ERROR */
             IF         COND(&RTNERROR *NE 0) THEN(DO)
             CHGVAR     VAR(&RTNERRORC) VALUE(&RTNERROR)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('File' +
                          |> &IFSFILE2 |> 'not found') MSGTYPE(*ESCAPE)
             ENDDO

/* HANDLE NORMAL EXIT */

/* IF ERRORS OCCUR DURING COPY, LOG ERROR */
             SNDPGMMSG  MSGID(CPF9897) MSGF(QCPFMSG) MSGDTA('File' +
                          |> &IFSFILE2 |> 'was found') +
                          MSGTYPE(*ESCAPE)

              RETURN     /* NORMAL END OF PROGRAM */

/*****************************************************************/
/* HANDLE ERRORS */
/*****************************************************************/
 ERRORS:
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
                          occurred while trying to access file' |> +
                          &IFSFILE2) MSGTYPE(*ESCAPE)

             ENDPGM
