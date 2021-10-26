        PGM        PARM(&SQLQUERY &OUTFILE &EMPTYERROR &PROMPT)

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
/* Drop the temp table if it exists                */
/* Catch error. Create will fail if already found. */
/*----------------------------------------------------------------------------*/
             CHGVAR     VAR(&SQL) VALUE('DROP TABLE' |> &TEMPLIB |< +
                          '/' |< &TEMPFILE)

             IF         COND(&PROMPT *EQ *YES) THEN(DO)
             ? RUNSQL   ??SQL(&SQL) ??COMMIT(*NONE)
             MONMSG     MSGID(CPF0000)
             ENDDO

             IF         COND(&PROMPT *NE *YES) THEN(DO)
             RUNSQL     SQL(&SQL) COMMIT(*NONE)
             MONMSG     MSGID(CPF0000)
             ENDDO

/*----------------------------------------------------------------------------*/
/* Create temp table from another table using SQL */
/*----------------------------------------------------------------------------*/
             CHGVAR     VAR(&SQL) VALUE('create table' |> &TEMPLIB +
                          |< '/' |< &TEMPFILE |> 'as (' |< +
                          &SQLQUERY |< ') with data')
             RUNSQL     SQL(&SQL) COMMIT(*NONE)

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

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Temp +
                          file' |> &TEMPLIB |< '/' |< &TEMPFILE |> +
                          'was created from query.' |> &RECORDSC |> +
                          'records') MSGTYPE(&COMPMSGTYP)

             RETURN
ERRORS:
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
                          occurred running SQL query commands +
                          check the job log') MSGTYPE(*ESCAPE)

             ENDPGM
