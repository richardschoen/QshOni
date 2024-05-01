/* Desc: Sample Command to Use QSHPYRUN Internally-RPGLE */

             PGM        PARM(&ARGS)

             /* Sample command proessing program for */
             /* using embedded QSHPYRUN command.     */

             /* Variable for all potential passed args, */
             /* plus 2 characters for the parm count.   */
             DCL        VAR(&ARGS) TYPE(*CHAR) LEN(8002)
             DCL        VAR(&CLCMD) TYPE(*CHAR) LEN(9999)
             DCL        VAR(&CLCMDLEN) TYPE(*DEC) LEN(15 5)

             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))

             /* Build QSHPYRUN command from passed args, */
             CALL       PGM(TSTPYRUNR) PARM(&ARGS &CLCMD &CLCMDLEN)

             /* Output command to command line */
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA(&CLCMD)

             /* Call the derived QSHPYRUN command.*/
             CALL       PGM(QCMDEXC) PARM(&CLCMD &CLCMDLEN)

             /* Ignore prompting exit error. Remove for prod */
             MONMSG     MSGID(CPF6801)

             RETURN

             /* Handle Errors */
ERRORS:
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
                          occurred. Check the joblog') MSGTYPE(*ESCAPE)

             ENDPGM
