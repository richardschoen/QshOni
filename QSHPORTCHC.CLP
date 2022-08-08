             PGM        PARM(&LOCALPORT &CONNTYPE &OUTFILE)

             DCL        VAR(&LOCALPORT) TYPE(*DEC) LEN(5)
             DCL        VAR(&CONNTYPE) TYPE(*CHAR) LEN(4)
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
             DCL        VAR(&QT) TYPE(*CHAR) LEN(1) VALUE('''')

             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))

/*----------------------------------------------------------------------------*/
/* Set up SQL query for port                                                  */
/*----------------------------------------------------------------------------*/
             CHGVAR     VAR(&SQL) VALUE('SELECT * FROM +
                          QSYS2.NETSTAT_INFO WHERE +
                          CONNECTION_TYPE=' |< &QT |< &CONNTYPE |< +
                          &QT |> 'AND LOCAL_PORT=' |< +
                          %CHAR(&LOCALPORT))

/*----------------------------------------------------------------------------*/
/* Parse outfile parm */
/*----------------------------------------------------------------------------*/
             CHGVAR     VAR(&TEMPLIB) VALUE(%SST(&OUTFILE 11 10))
             CHGVAR     VAR(&TEMPFILE) VALUE(%SST(&OUTFILE 1 10))

/*----------------------------------------------------------------------------*/
/* Run the DB2 services query */
/*----------------------------------------------------------------------------*/
             QSHONI/QSHQRYTMP SQL(&SQL) OUTFILE(&TEMPLIB/&TEMPFILE) +
                          EMPTYERROR(*YES)

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Port' +
                          |> %CHAR(&LOCALPORT) |> 'appears to be +
                          active on connection type' |> &CONNTYPE) +
                          MSGTYPE(*COMP)

             RETURN
ERRORS:
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
                          occurred running TCP port' |> +
                          %CHAR(&LOCALPORT) |> 'check. Most likely +
                          the selected port is not active') +
                          MSGTYPE(*ESCAPE)

             ENDPGM
