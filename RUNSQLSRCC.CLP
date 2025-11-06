             PGM        PARM(&SRCFILE &SRCMBR &PARMS &PARMVALS +
                          &PROMPT &DLTTMPSRC &COMMIT &NAMING +
                          &OPTION &OUTPUT &SECLVLTXT &DSPOUTPUT +
                          &DLTCMTLINE &DSPTMPSRC &PRTTMPSRC &SPLF +
                          &USRDTA &USRDFNDTA &PRTOUTQALL)

             DCL        VAR(&DLTCMTLINE) TYPE(*CHAR) LEN(4)
             DCL        VAR(&DSPTMPSRC) TYPE(*CHAR) LEN(4)
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

             /* Parse SQL source member name */
             CHGVAR     VAR(&SQLSRCLIB) VALUE(%SST(&SRCFILE 11 10))
             CHGVAR     VAR(&SQLSRCFILE) VALUE(%SST(&SRCFILE 1 10))

             CHKOBJ     OBJ(&SQLSRCLIB/&SQLSRCFILE) OBJTYPE(*FILE) +
                          MBR(&SRCMBR)
             MONMSG     MSGID(CPF0000) EXEC(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('SQL +
                          Source member' |> &SQLSRCLIB |< '/' |< +
                          &SQLSRCFILE |< '(' |< &SRCMBR |< ') was +
                          not found or you don''t have access. +
                          RUNSQLSRC action query cancelled') +
                          MSGTYPE(*ESCAPE)
             ENDDO

             /* Drop diag message into joblog for SQL source */
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('INFO: +
                          SQL Source member' |> &SQLSRCLIB |< '/' +
                          |< &SQLSRCFILE |< '(' |< &SRCMBR |< ') is +
                          being used to run query') TOPGMQ(*SAME) +
                          MSGTYPE(*DIAG)

             /* Delete temporary source file */
             /* Make sure doesn't exist.     */
             DLTF       FILE(QTEMP/TMPQRYSRC)
             MONMSG     MSGID(CPF0000)

             /* Create temporary source file */
             CRTSRCPF   FILE(QTEMP/TMPQRYSRC) RCDLEN(240)
             ADDPFM     FILE(QTEMP/TMPQRYSRC) MBR(TMPQRYSRC) +
                          SRCTYPE(SQL)

             /* Make snapshot of source member to QTEMP for our job */
             CPYSRCF    FROMFILE(&SQLSRCLIB/&SQLSRCFILE) +
                          TOFILE(QTEMP/TMPQRYSRC) FROMMBR(&SRCMBR) +
                          TOMBR(TMPQRYSRC) MBROPT(*REPLACE)

             /* Read SQL from source member, remove comment values  */
             /* and update the temp SQL member file in QTEMP */
             OVRDBF     FILE(TMPQRYSRC) TOFILE(QTEMP/TMPQRYSRC) +
                          MBR(*FIRST) OVRSCOPE(*ACTGRPDFN)
             CALL       PGM(RUNSQLSR3R) PARM((&DLTCMTLINE) (&RTNERROR))
             DLTOVR     FILE(TMPQRYSRC) LVL(*ACTGRPDFN)

             /* If rtnerror <> '0', bail out now     */
             IF         COND(&RTNERROR *EQ '1') THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Error +
                          occurred removing comments from SQL') +
                          MSGTYPE(*ESCAPE)
             ENDDO

             /* Read SQL from source member, scan and replace values */
             /* and update the temp SQL member file in QTEMP */
             OVRDBF     FILE(TMPQRYSRC) TOFILE(QTEMP/TMPQRYSRC) +
                          MBR(*FIRST) OVRSCOPE(*ACTGRPDFN)
             CALL       PGM(RUNSQLSRCR) PARM(&PARMS &PARMVALS +
                          &RTNERROR)
             DLTOVR     FILE(TMPQRYSRC) LVL(*ACTGRPDFN)


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

             /* Display actual query source that will run */
             /* if DSPTMPSRC is *YES.               */
             IF         COND(&DSPTMPSRC *EQ *YES) THEN(DO)
             STRSEU     SRCFILE(QTEMP/TMPQRYSRC) SRCMBR(TMPQRYSRC)
             MONMSG     MSGID(CPF0000)
             ENDDO

             /* Output actual query source that will run */
             /* if PRTTMPSRC is *YES.               */
             IF         COND(&PRTTMPSRC *EQ *YES) THEN(DO)

             /* If spool file name = *SRCMBR, name after source mbr */
             IF         COND(&SPLF *EQ *SRCMBR) THEN(DO)
             CHGVAR     VAR(&SPLF) VALUE(&SRCMBR)
             ENDDO
             /* If user data = *SRCMBR, name after source mbr */
             IF         COND(&USRDTA *EQ *SRCMBR) THEN(DO)
             CHGVAR     VAR(&USRDTA) VALUE(&SRCMBR)
             ENDDO
             /* If user def data=*SRCMBR, set to source mbr */
             IF         COND(&USRDFNDTA *EQ *SRCMBR) THEN(DO)
             CHGVAR     VAR(&USRDFNDTA) VALUE(&SRCMBR)
             ENDDO

             /* Override without specific outq */
             IF         COND(&PRTOUTQ *EQ *SAME) THEN(DO)
             OVRPRTF    FILE(QSYSPRT) TOFILE(*FILE) PAGESIZE(*N 198) +
                          HOLD(*YES) USRDTA(&USRDTA) +
                          USRDFNDTA(&USRDFNDTA) SPLFNAME(&SPLF) +
                          OVRSCOPE(*ACTGRPDFN)
             ENDDO
             IF         COND(&PRTOUTQ *NE *SAME) THEN(DO)
             /* Override with specific outq */
             OVRPRTF    FILE(QSYSPRT) TOFILE(*FILE) PAGESIZE(*N 198) +
                          OUTQ(&PRTOUTQLIB/&PRTOUTQ) HOLD(*YES) +
                          USRDTA(&USRDTA) USRDFNDTA(&USRDFNDTA) +
                          SPLFNAME(&SPLF) OVRSCOPE(*ACTGRPDFN)
             ENDDO

             CPYF       FROMFILE(QTEMP/TMPQRYSRC) TOFILE(QSYSPRT)
             DLTOVR     FILE(QSYSPRT) LVL(*ACTGRPDFN)

             ENDDO  /* ENDDO print source */

             /* Run the SQL action query now */
             /* Override without specific outq */
             IF         COND(&PRTOUTQ *EQ *SAME) THEN(DO)
             OVRPRTF    FILE(QSYSPRT) TOFILE(*FILE) PAGESIZE(*N 198) +
                          HOLD(*YES) USRDTA(&USRDTA) +
                          USRDFNDTA(&USRDFNDTA) SPLFNAME(&SPLF) +
                          OVRSCOPE(*ACTGRPDFN)
             ENDDO
             IF         COND(&PRTOUTQ *NE *SAME) THEN(DO)
             /* Override with specific outq */
             OVRPRTF    FILE(QSYSPRT) TOFILE(*FILE) PAGESIZE(*N 198) +
                          OUTQ(&PRTOUTQLIB/&PRTOUTQ) HOLD(*YES) +
                          USRDTA(&USRDTA) USRDFNDTA(&USRDFNDTA) +
                          SPLFNAME(&SPLF) OVRSCOPE(*ACTGRPDFN)
             ENDDO

             IF         COND(&PROMPT *EQ *YES) THEN(DO)
             ?          QSYS/RUNSQLSTM ??SRCFILE(QTEMP/TMPQRYSRC) +
                          ??SRCMBR(TMPQRYSRC) ??COMMIT(&COMMIT) +
                          ??NAMING(&NAMING) ??OPTION(&OPTION) +
                          ??SECLVLTXT(&SECLVLTXT) ??OUTPUT(&OUTPUT)
             ENDDO

             IF         COND(&PROMPT *NE *YES) THEN(DO)
             QSYS/RUNSQLSTM SRCFILE(QTEMP/TMPQRYSRC) +
                          SRCMBR(TMPQRYSRC) COMMIT(&COMMIT) +
                          NAMING(&NAMING) OPTION(&OPTION) +
                          SECLVLTXT(&SECLVLTXT) OUTPUT(&OUTPUT)
             ENDDO

             DLTOVR     FILE(QSYSPRT) LVL(*ACTGRPDFN)

             /* Delete temp source member if specified */
             IF         COND(&DLTTMPSRC *EQ *YES) THEN(DO)
             DLTF       FILE(QTEMP/TMPQRYSRC)
             ENDDO

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
                          action query ran successfully. Source +
                          member' |> &SQLSRCLIB |< '/' |< +
                          &SQLSRCFILE |< '(' |< &SRCMBR |< ')') +
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
                          MSGDTA('RUNSQLSRC-Errors occurred running +
                          SQL action query. Check the job +
                          log and your SQL source query') +
                          MSGTYPE(*ESCAPE)

             ENDPGM
