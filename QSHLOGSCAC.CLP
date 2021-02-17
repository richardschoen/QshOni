/*------------------------------------------------------------*/
/* @@LIBRARY: QSHONI                                          */
/* @@FILE: SOURCE                                             */
/* @@MEMBER: QSHLOGSCAC                                       */
/* @@TYPE: CLP                                                */
/* @@TEXT: Scan Qshell Log File for Value                     */
/*------------------------------------------------------------*/
/*----------------------------------------------------------*/
/* QSHLOGSCAC - Scan Qshell log for Values                  */
/*----------------------------------------------------------*/
             PGM        PARM(&VALUE &EXACTMATCH)

             DCL        VAR(&VALUE) TYPE(*CHAR) LEN(1024)
             DCL        VAR(&EXACTMATCH) TYPE(*CHAR) LEN(4)
             DCL        VAR(&RTNFOUND) TYPE(*CHAR) LEN(1)

             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))

             /* Check for STDOUT log file */
             CHKOBJ     OBJ(QTEMP/STDOUTQSH) OBJTYPE(*FILE)
             MONMSG     MSGID(CPF0000) EXEC(SNDPGMMSG MSGID(CPF9898) +
                          MSGF(QCPFMSG) MSGDTA('Log file +
                          QTEMP/STDOUTQSH does not exist. You must +
                          use QSHEXEC before trying to scan the +
                          log') MSGTYPE(*ESCAPE))

             /* Call program to scan the log now */
             OVRDBF     FILE(STDOUTQSH) TOFILE(QTEMP/STDOUTQSH)
             CALL       PGM(QSHLOGSCAR) PARM(&VALUE &EXACTMATCH +
                          &RTNFOUND)
             DLTOVR     FILE(STDOUTQSH)

             IF         COND(&RTNFOUND *EQ '1') THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Value +
                          was found in Qshell log') MSGTYPE(*COMP)
             ENDDO
             IF         COND(&RTNFOUND *EQ '0') THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Value +
                          was NOT found in Qshell log') +
                          MSGTYPE(*ESCAPE)
             ENDDO

             RETURN

ERRORS:
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
                          scanning for value in Qshell log') +
                          MSGTYPE(*ESCAPE)

