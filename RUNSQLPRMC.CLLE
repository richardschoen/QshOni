             PGM        PARM(&SQL &PARMS &PARMVALS &PROMPT &COMMIT +
                          &NAMING &OPTION &SECLVLTXT &DSPOUTPUT +
                          &SPLF &USRDTA &USRDFNDTA &PRTOUTQALL)

             DCL        VAR(&USRDFNDTA) TYPE(*CHAR) LEN(255)
             DCL        VAR(&USRDTA) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PRTOUTQALL) TYPE(*CHAR) LEN(20)
             DCL        VAR(&PRTOUTQ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PRTOUTQLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SPLF) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PRTTMPSRC) TYPE(*CHAR) LEN(4)
             DCL        VAR(&SECLVLTXT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&DSPOUTPUT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&OPTION) TYPE(*CHAR) LEN(10)
             DCL        VAR(&OUTPUT) TYPE(*CHAR) LEN(10)
             DCL        VAR(&RTNERROR) TYPE(*CHAR) LEN(1)
             DCL        VAR(&COMMIT) TYPE(*CHAR) LEN(5)
             DCL        VAR(&NAMING) TYPE(*CHAR) LEN(4)
             DCL        VAR(&PARMS)  TYPE(*CHAR) LEN(3002)
             DCL        VAR(&PARMVALS) TYPE(*CHAR) LEN(3002)
             DCL        VAR(&IDCOLNAME) TYPE(*CHAR) LEN(30)
             DCL        VAR(&CRTIDCOL) TYPE(*CHAR) LEN(4)
             DCL        VAR(&DLTTMPSRC) TYPE(*CHAR) LEN(4)
             DCL        VAR(&SQLIFSFILE) TYPE(*CHAR) LEN(255)
             DCL        VAR(&SQLLOC) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SRCFILE) TYPE(*CHAR) LEN(20)
             DCL        VAR(&SQLSRCFILE) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SQLSRCLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SRCMBR) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PROMPT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&EMPTYERROR) TYPE(*CHAR) LEN(4)
             DCL        VAR(&IFILE) TYPE(*CHAR) LEN(10) VALUE(QCUSTCDT)
             DCL        VAR(&ILIB) TYPE(*CHAR) LEN(10) VALUE(QIWS)
             DCL        VAR(&OUTFILE) TYPE(*CHAR) LEN(20)
             DCL        VAR(&TEMPFILE) TYPE(*CHAR) LEN(10) VALUE(CUST1)
             DCL        VAR(&TEMPLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SQL) TYPE(*CHAR) LEN(5000)
             DCL        VAR(&SQLQUERY) TYPE(*CHAR) LEN(5000)
             DCL        VAR(&RECORDS) TYPE(*DEC) LEN(10)
             DCL        VAR(&RECORDSC) TYPE(*CHAR) LEN(10)
             DCL        VAR(&COMPMSGTYP) TYPE(*CHAR) LEN(10) +
                          VALUE(*COMP)

             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))

             /* Extract output queue info.  */
             CHGVAR     VAR(&PRTOUTQ) VALUE(%SST(&PRTOUTQALL 1 10))
             CHGVAR     VAR(&PRTOUTQLIB) VALUE(%SST(&PRTOUTQALL 11 10))

             /* Drop diag message into joblog for SQL source */
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('INFO: +
                          SQL Source member' |> &SQLSRCLIB |< '/' +
                          |< &SQLSRCFILE |< '(' |< &SRCMBR |< ') is +
                          being used to run query') TOPGMQ(*SAME) +
                          MSGTYPE(*DIAG)


             /* Replace parms in SQL statement */
             CALL       PGM(RUNSQLPRMR) PARM(&SQL &PARMS &PARMVALS +
                          &RTNERROR)

             /* If rtnerror <> '0', bail out now     */
             IF         COND(&RTNERROR *EQ '1') THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Same +
                          number of parms and parm values are +
                          required to be passed') MSGTYPE(*ESCAPE)
             ENDDO
             IF         COND(&RTNERROR *EQ '2') THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('At +
                          least one parameter required error +
                          occurred while processing SQL source +
                          member parameters') MSGTYPE(*ESCAPE)
             ENDDO
             IF         COND(&RTNERROR *EQ '3') THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Unknown +
                          error occurred while handling parameters. +
                          Check the joblog') MSGTYPE(*ESCAPE)
             ENDDO

             /* Run the SQL action query now */
             /* Override without specific outq */
             IF         COND(&PRTOUTQ *EQ *SAME) THEN(DO)
             OVRPRTF    FILE(QSYSPRT) TOFILE(*FILE) PAGESIZE(*N 198) +
                          HOLD(*YES) USRDFNDTA(&USRDFNDTA) +
                          SPLFNAME(&SPLF) OVRSCOPE(*ACTGRPDFN)
             ENDDO
             IF         COND(&PRTOUTQ *NE *SAME) THEN(DO)
             /* Override with specific outq */
             OVRPRTF    FILE(QSYSPRT) TOFILE(*FILE) PAGESIZE(*N 198) +
                          OUTQ(&PRTOUTQLIB/&PRTOUTQ) HOLD(*YES) +
                          USRDFNDTA(&USRDFNDTA) SPLFNAME(&SPLF) +
                          OVRSCOPE(*ACTGRPDFN)
             ENDDO

             IF         COND(&PROMPT *EQ *YES) THEN(DO)
             ?          QSYS/RUNSQL SQL(&SQL) ??COMMIT(&COMMIT) +
                          ??NAMING(&NAMING) ??OPTION(&OPTION) +
                          ??SECLVLTXT(&SECLVLTXT)
             ENDDO

             IF         COND(&PROMPT *NE *YES) THEN(DO)
             QSYS/RUNSQL SQL(&SQL) COMMIT(&COMMIT) NAMING(&NAMING) +
                          OPTION(&OPTION) SECLVLTXT(&SECLVLTXT)
             ENDDO

             DLTOVR     FILE(QSYSPRT) LVL(*ACTGRPDFN)

             /* Last spool file should be most recent query */
             IF         COND(&DSPOUTPUT *EQ *YES) THEN(DO)
             DSPSPLF    FILE(&SPLF) SPLNBR(*LAST)
             MONMSG     MSGID(CPF0000) EXEC(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('No +
                          RUNSQLSTM listing spool files +
                          available.') TOPGMQ(*SAME) MSGTYPE(*DIAG)
             ENDDO
             ENDDO


             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('SQL +
                          action query ran successfully.') +
                          MSGTYPE(*COMP)

             RETURN
ERRORS:
             /* Last spool file should be most recent query */
             IF         COND(&DSPOUTPUT *EQ *YES) THEN(DO)
             DSPSPLF    FILE(&SPLF) SPLNBR(*LAST)
             MONMSG     MSGID(CPF0000) EXEC(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('No +
                          RUNSQLSTM listing spool files +
                          available.') TOPGMQ(*SAME) MSGTYPE(*DIAG)
             ENDDO
             ENDDO

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA('RUNSQLPRM-Errors occurred running +
                          SQL action query. Check the job +
                          log and your SQL source query') +
                          MSGTYPE(*ESCAPE)

             ENDPGM
