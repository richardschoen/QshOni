             PGM        PARM(&CMDLINE &SETPKGPATH &DSPSTDOUT +
                          &LOGSTDOUT &PRTSTDOUT &DLTSTDOUT +
                          &IFSSTDOUT &IFSFILE &IFSOPT &CCSID +
                          &PRTSPLF &PRTUSRDTA &PRTTXT &PRTHOLD +
                          &PRTOUTQALL)

/*----------------------------------------------------------------------------*/
/* Variables                                                                  */
/*----------------------------------------------------------------------------*/
             DCL        VAR(&PRTHOLD) TYPE(*CHAR) LEN(4)
             DCL        VAR(&PRTOUTQALL) TYPE(*CHAR) LEN(20)
             DCL        VAR(&PRTOUTQ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PRTOUTQLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&CMDLINE) TYPE(*CHAR) LEN(5000)
             DCL        VAR(&CURLCMDLIN) TYPE(*CHAR) LEN(5000)
             DCL        VAR(&SETPKGPATH) TYPE(*CHAR) LEN(4)
             DCL        VAR(&DSPSTDOUT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&LOGSTDOUT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&DLTSTDOUT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&PRTSTDOUT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&IFSSTDOUT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&IFSOPT) TYPE(*CHAR) LEN(10)
             DCL        VAR(&IFSFILE) TYPE(*CHAR) LEN(255)
             DCL        VAR(&PRTSPLF) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PRTUSRDTA) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PRTTXT) TYPE(*CHAR) LEN(30)
             DCL        VAR(&QT) TYPE(*CHAR) LEN(1) VALUE('''')
             DCL        VAR(&CCSID) TYPE(*CHAR) LEN(10)

/*----------------------------------------------------------------------------*/
/* MONITOR FOR GLOBAL ERROR. ANY ERROR IS A CAUSE TO BLOW OUT OF HERE         */
/* AND WE WANT A GRACEFUL EXIT.                                               */
/*----------------------------------------------------------------------------*/
             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))

/*----------------------------------------------------------------------------*/
/* Extract output queue info.                                                 */
/*----------------------------------------------------------------------------*/
             CHGVAR     VAR(&PRTOUTQ) VALUE(%SST(&PRTOUTQALL 1 10))
             CHGVAR     VAR(&PRTOUTQLIB) VALUE(%SST(&PRTOUTQALL 11 10))

/*----------------------------------------------------------------------------*/
/* MAIN                                                                       */
/*----------------------------------------------------------------------------*/

             /* Build curl command line to pass to qshell */
             CHGVAR     VAR(&CURLCMDLIN) VALUE('curl' |>  +
                          &CMDLINE)

             /* Run the curl command via QSHEXEC */
             QSHONI/QSHEXEC CMDLINE(&CURLCMDLIN) +
                          SETPKGPATH(&SETPKGPATH) +
                          DSPSTDOUT(&DSPSTDOUT) +
                          LOGSTDOUT(&LOGSTDOUT) +
                          PRTSTDOUT(&PRTSTDOUT) +
                          DLTSTDOUT(&DLTSTDOUT) +
                          IFSSTDOUT(&IFSSTDOUT) IFSFILE(&IFSFILE) +
                          IFSOPT(&IFSOPT) CCSID(&CCSID) +
                          PRTSPLF(&PRTSPLF) PRTUSRDTA(&PRTUSRDTA) +
                          PRTTXT(&PRTTXT) PRTHOLD(&PRTHOLD) +
                          PRTOUTQ(&PRTOUTQLIB/&PRTOUTQ)

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('QShell +
                          curl command completed') MSGTYPE(*COMP)

             RETURN

ERRORS:
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('QShell +
                          curl command failed') MSGTYPE(*ESCAPE)

 ENDPGM:
             ENDPGM
