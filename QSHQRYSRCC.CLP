             PGM        PARM(&SRCFILE &SRCMBR &SQLIFSFILE &PARMS +
                          &PARMVALS &OUTFILE &EMPTYERROR &NAMING +
                          &PROMPT &CRTIDCOL &IDCOLNAME &DLTTMPSRC +
                          &SQLLOC &DLTCMTLINE &DSPTMPSRC)

             DCL        VAR(&DLTCMTLINE) TYPE(*CHAR) LEN(4)
             DCL        VAR(&DSPTMPSRC) TYPE(*CHAR) LEN(4)
             DCL        VAR(&RTNERROR) TYPE(*CHAR) LEN(1)
             DCL        VAR(&PARMS)  TYPE(*CHAR) LEN(3002)
             DCL        VAR(&PARMVALS) TYPE(*CHAR) LEN(3002)
             DCL        VAR(&SQLQUAL) TYPE(*CHAR) LEN(1)
             DCL        VAR(&NAMING) TYPE(*CHAR) LEN(4)
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

/*----------------------------------------------------------------------------*/
/* Parse source member parm info if SQLLOC = *SRCMBR */
/*----------------------------------------------------------------------------*/
             IF         COND(&SQLLOC *EQ *SRCMBR) THEN(DO)

             CHGVAR     VAR(&SQLSRCLIB) VALUE(%SST(&SRCFILE 11 10))
             CHGVAR     VAR(&SQLSRCFILE) VALUE(%SST(&SRCFILE 1 10))

             CHKOBJ     OBJ(&SQLSRCLIB/&SQLSRCFILE) OBJTYPE(*FILE) +
                          MBR(&SRCMBR)
             MONMSG     MSGID(CPF0000) EXEC(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('SQL +
                          Source member' |> &SQLSRCLIB |< '/' |< +
                          &SQLSRCFILE |< '(' |< &SRCMBR |< ') was +
                          not found or you don''t have access. +
                          Query cancelled') MSGTYPE(*ESCAPE)
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

             ENDDO        /* ENDDO *SRCMBR */

/*----------------------------------------------------------------------------*/
/* Parse source member parm info if SQLLOC = *IFSFILE */
/*----------------------------------------------------------------------------*/
             IF         COND(&SQLLOC *EQ *IFSFILE) THEN(DO)

             /* IFS file cannot be blank */
             IF         COND(&SQLIFSFILE *EQ ' ') THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('SQL +
                          IFS file not specified for *IFSFILE +
                          option. Query cancelled') MSGTYPE(*ESCAPE)
             ENDDO

             /* Check for SQL in IFS file */
             QSHONI/QSHIFSCHK FILNAM(&SQLIFSFILE)
             /* IFS file not found. bail out */
             MONMSG     MSGID(CPF9898) EXEC(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('SQL +
                          IFS file' |> &SQLIFSFILE |> 'not found. +
                          Query cancelled') MSGTYPE(*ESCAPE)
             ENDDO
             /* IFS file found */
             MONMSG     MSGID(CPF9897) EXEC(DO)
             ENDDO

             /* Drop diag message into joblog for SQL source */
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA('INFO: SQL IFS file' |> &SQLIFSFILE +
                          |> 'is being used to run query') +
                          TOPGMQ(*SAME) MSGTYPE(*DIAG)

             /* Delete temporary source file */
             /* Make sure doesn't exist.     */
             DLTF       FILE(QTEMP/TMPQRYSRC)
             MONMSG     MSGID(CPF0000)

             /* Create temporary source file */
             CRTSRCPF   FILE(QTEMP/TMPQRYSRC) RCDLEN(240)
             ADDPFM     FILE(QTEMP/TMPQRYSRC) MBR(TMPQRYSRC) +
                          SRCTYPE(SQL)

             CHGVAR     VAR(&SQLSRCLIB) VALUE(QTEMP)
             CHGVAR     VAR(&SQLSRCFILE) VALUE(TMPQRYSRC)
             CHGVAR     VAR(&SRCMBR) VALUE(TMPQRYSRC)

             /* Copy source member to source file in QTEMP */
             CPYFRMSTMF FROMSTMF(&SQLIFSFILE) +
                          TOMBR('/QSYS.LIB/QTEMP.LIB/TMPQRYSRC.FILE/T+
                          MPQRYSRC.MBR') MBROPT(*REPLACE) +
                          CVTDTA(*AUTO) STMFCCSID(*STMF) +
                          DBFCCSID(*FILE)

             ENDDO        /* ENDDO *IFSFILE */

/*----------------------------------------------------------------------------*/
/* Read SQL from source member, scan and replace values */
/* and update the temp SQL member file in QTEMP */
/*----------------------------------------------------------------------------*/
             OVRDBF     FILE(TMPQRYSRC) TOFILE(QTEMP/TMPQRYSRC) +
                          MBR(*FIRST) OVRSCOPE(*ACTGRPDFN)
             CALL       PGM(QSHQRYSR2R) PARM(&PARMS &PARMVALS +
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

/*----------------------------------------------------------------------------*/
/* Read SQL from source member, remove comment values                */
/* and update the temp SQL member file in QTEMP                      */
/*----------------------------------------------------------------------------*/
             OVRDBF     FILE(TMPQRYSRC) TOFILE(QTEMP/TMPQRYSRC) +
                          MBR(*FIRST) OVRSCOPE(*ACTGRPDFN)
             CALL       PGM(QSHQRYSR3R) PARM((&DLTCMTLINE) (&RTNERROR))
             DLTOVR     FILE(TMPQRYSRC) LVL(*ACTGRPDFN)

             /* If rtnerror <> '0', bail out now     */
             IF         COND(&RTNERROR *EQ '1') THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Error +
                          occurred removing comments from SQL') +
                          MSGTYPE(*ESCAPE)
             ENDDO

/*----------------------------------------------------------------------------*/
/* Read SQL from source member in QTEMP and compose final query               */
/*----------------------------------------------------------------------------*/
             OVRDBF     FILE(TMPSRCMBR) TOFILE(QTEMP/TMPQRYSRC) +
                          MBR(*FIRST) OVRSCOPE(*ACTGRPDFN)
             CALL       PGM(QSHQRYSRCR) PARM(&SQLQUERY)
             DLTOVR     FILE(TMPSRCMBR) LVL(*ACTGRPDFN)

             IF         COND(&SQLQUERY *EQ ' ') THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('SQL +
                          Source member' |> &SQLSRCLIB |< '/' |< +
                          &SQLSRCFILE |< '(' |< &SRCMBR |< ') was +
                          empty or has blank lines. Query +
                          cancelled') MSGTYPE(*ESCAPE)
             ENDDO

/*----------------------------------------------------------------------------*/
/* Display actual query source that will run */
/* if DSPTMPSRC is *YES.               */
/*----------------------------------------------------------------------------*/
             IF         COND(&DSPTMPSRC *EQ *YES) THEN(DO)
             STRSEU     SRCFILE(QTEMP/TMPQRYSRC) SRCMBR(TMPQRYSRC)
             MONMSG     MSGID(CPF0000)
             ENDDO

/*----------------------------------------------------------------------------*/
/* Parse outfile parm */
/*----------------------------------------------------------------------------*/
             CHGVAR     VAR(&TEMPLIB) VALUE(%SST(&OUTFILE 11 10))
             CHGVAR     VAR(&TEMPFILE) VALUE(%SST(&OUTFILE 1 10))

/*----------------------------------------------------------------------------*/
/* Create record count data area */
/*----------------------------------------------------------------------------*/
             CHKOBJ     OBJ(QTEMP/SQLQRYCNT) OBJTYPE(*DTAARA)
             MONMSG     MSGID(CPF0000) EXEC(DO)
             CRTDTAARA  DTAARA(QTEMP/SQLQRYCNT) TYPE(*DEC) LEN(10 0) +
                          TEXT('Query Result Record Count')
             ENDDO
             CHGDTAARA  DTAARA(QTEMP/SQLQRYCNT *ALL) VALUE(0)

/*----------------------------------------------------------------------------*/
/* Create outfile info data area. Added in case we add a *GEN option */
/*----------------------------------------------------------------------------*/
             CHKOBJ     OBJ(QTEMP/SQLQRYFIL) OBJTYPE(*DTAARA)
             MONMSG     MSGID(CPF0000) EXEC(DO)
             CRTDTAARA  DTAARA(QTEMP/SQLQRYFIL) TYPE(*CHAR) LEN(10) +
                          TEXT('Query Result File Name')
             ENDDO
             CHGDTAARA  DTAARA(QTEMP/SQLQRYFIL *ALL) VALUE(' ')

             CHKOBJ     OBJ(QTEMP/SQLQRYLIB) OBJTYPE(*DTAARA)
             MONMSG     MSGID(CPF0000) EXEC(DO)
             CRTDTAARA  DTAARA(QTEMP/SQLQRYLIB) TYPE(*CHAR) LEN(10) +
                          TEXT('Query Result Lib Name')
             ENDDO
             CHGDTAARA  DTAARA(QTEMP/SQLQRYLIB *ALL) VALUE(' ')

/*----------------------------------------------------------------------------*/
/* Determine SQL table qualifer to use for *SYS vs *SQL. */
/*----------------------------------------------------------------------------*/
             IF         COND(&NAMING *EQ *SYS) THEN(CHGVAR +
                          VAR(&SQLQUAL) VALUE('/'))
             IF         COND(&NAMING *NE *SYS) THEN(CHGVAR +
                          VAR(&SQLQUAL) VALUE('.'))

/*----------------------------------------------------------------------------*/
/* Drop the temp table if it exists                */
/* Catch error. Create will fail if already found. */
/*----------------------------------------------------------------------------*/
             CHGVAR     VAR(&SQL) VALUE('DROP TABLE' |> &TEMPLIB |< +
                          '/' |< &TEMPFILE)

             IF         COND(&PROMPT *EQ *YES) THEN(DO)
             ? QSYS/RUNSQL   ??SQL(&SQL) ??COMMIT(*NONE) ??NAMING(*SYS)
             MONMSG     MSGID(CPF0000)
             ENDDO

             IF         COND(&PROMPT *NE *YES) THEN(DO)
             QSYS/RUNSQL     SQL(&SQL) COMMIT(*NONE) NAMING(*SYS)
             MONMSG     MSGID(CPF0000)
             ENDDO

/*----------------------------------------------------------------------------*/
/* Create temp table from another table using SQL */
/*----------------------------------------------------------------------------*/
             CHGVAR     VAR(&SQL) VALUE('create table' |> &TEMPLIB +
                          |< &SQLQUAL |< &TEMPFILE |> 'as (' |< +
                          &SQLQUERY |< ') with data')

             IF         COND(&PROMPT *EQ *YES) THEN(DO)
             ? QSYS/RUNSQL   ??SQL(&SQL) ??COMMIT(*NONE) NAMING(&NAMING)
             MONMSG     MSGID(CPF0000)
             ENDDO

             IF         COND(&PROMPT *NE *YES) THEN(DO)
             QSYS/RUNSQL     SQL(&SQL) COMMIT(*NONE)  NAMING(&NAMING)
             MONMSG     MSGID(CPF0000)
             ENDDO

/*----------------------------------------------------------------------------*/
/* Get record count */
/*----------------------------------------------------------------------------*/
             /* Check PF record count */
             RTVMBRD    FILE(&TEMPLIB/&TEMPFILE) MBR(*FIRST) +
                          NBRCURRCD(&RECORDS)
             CHGVAR     VAR(&RECORDSC) VALUE(&RECORDS)
             /* Save record count to data area */
             CHGDTAARA  DTAARA(QTEMP/SQLQRYCNT *ALL) VALUE(&RECORDS)
             /* Set temp file data areas on query success */
             CHGDTAARA  DTAARA(QTEMP/SQLQRYFIL *ALL) VALUE(&TEMPFILE)
             CHGDTAARA  DTAARA(QTEMP/SQLQRYLIB *ALL) VALUE(&TEMPLIB)

/* If error on empty file, set to escape if no records */
             IF         COND(&EMPTYERROR *EQ *YES *AND &RECORDS *EQ +
                          0) THEN(DO)
             CHGVAR     VAR(&COMPMSGTYP) VALUE(*ESCAPE)
             ENDDO
             IF         COND(&EMPTYERROR *EQ *NO *AND &RECORDS *EQ +
                          0) THEN(DO)
             CHGVAR     VAR(&COMPMSGTYP) VALUE(*COMP)
             ENDDO

             /* Delete temporary source file */
             /* If selected.                 */
             /* IF         COND(&SQLLOC *EQ *IFSFILE) THEN(DO) */
             IF         COND(&DLTTMPSRC *EQ *YES) THEN(DO)
             DLTF       FILE(QTEMP/TMPQRYSRC)
             MONMSG     MSGID(CPF0000)
             ENDDO
            /*  ENDDO */

/* If enabled, add a unique identify column to the table with values */
             IF         COND(&CRTIDCOL *EQ *YES) THEN(DO)
             QSHONI/QSHQRYAID OUTFILE(&TEMPLIB/&TEMPFILE) +
                          IDCOLNAME(&IDCOLNAME) PROMPT(&PROMPT)
             ENDDO

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Temp +
                          file' |> &TEMPLIB |< '/' |< &TEMPFILE |> +
                          'was created from SQL query.' |> +
                          &RECORDSC |> 'records') MSGTYPE(&COMPMSGTYP)

             RETURN
ERRORS:
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA('QSHQRYSRC-Errors occurred running +
                          SQL query command. Check the job log and +
                          your SQL source query') MSGTYPE(*ESCAPE)

             ENDPGM
