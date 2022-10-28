/* Following command must be run before compile:                  */
/* QSHQRYTMP SQL('select JOB_NAME FROM QSYS2.NETSTAT_JOB_INFO')   */
/*          OUTFILE(QTEMP/TCPTMPEND)                              */

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
             DCL        VAR(&JOBNAME) TYPE(*CHAR) LEN(10)
             DCL        VAR(&JOBUSER) TYPE(*CHAR) LEN(10)
             DCL        VAR(&JOBNBR) TYPE(*CHAR) LEN(6)
             DCL        VAR(&CMDLINE) TYPE(*CHAR) LEN(200)
             DCL        VAR(&CMDLEN5) TYPE(*DEC) LEN(5)
             DCL        VAR(&CMDLEN5C) TYPE(*CHAR) LEN(5)
             DCL        VAR(&CMDLEN15) TYPE(*DEC) LEN(15 5)
             DCL        VAR(&SQLQRYCNT) TYPE(*DEC) LEN(10 0)
             DCLF       FILE(QTEMP/TCPTMPEND) ALWVARLEN(*YES)

             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))

/*----------------------------------------------------------------------------*/
/* Set up SQL query for port                                                  */
/*----------------------------------------------------------------------------*/
             CHGVAR     VAR(&SQL) VALUE('SELECT JOB_NAME FROM +
                          QSYS2.NETSTAT_JOB_INFO WHERE +
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
                          EMPTYERROR(*NO)
             RTVDTAARA  DTAARA(QTEMP/SQLQRYCNT *ALL) RTNVAR(&SQLQRYCNT)

             IF         COND(&SQLQRYCNT *EQ 0) THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('No jobs +
                          are active for port' |> +
                          %CHAR(&LOCALPORT)) MSGTYPE(*COMP)
             RETURN
             ENDDO

/*----------------------------------------------------------------------------*/
/* Read results from port query and end jobs */
/*----------------------------------------------------------------------------*/
 READ1:
             RCVF
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(END1))

             /* Set ENDJOB command to run and get command length */
             CHGVAR     VAR(&CMDLINE) VALUE('ENDJOB JOB(' |< +
                          %SST(&JOB_NAME 3 26) |< ') OPTION(*IMMED)')
             /* Get the command length */
             RTVMSG     MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA(&CMDLINE) MSGLEN(&CMDLEN5)
             CHGVAR     VAR(&CMDLEN15) VALUE(&CMDLEN5)

             /* Run the command now */
             CALL       PGM(QCMDEXC) PARM(&CMDLINE &CMDLEN15)

             /* If job already ending ignore error */
             MONMSG     MSGID(CPF135D)

             GOTO       CMDLBL(READ1)
END1:

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA(%CHAR(&SQLQRYCNT) |> 'Jobs ended +
                          for port' |> %CHAR(&LOCALPORT)) +
                          MSGTYPE(*COMP)

             RETURN
ERRORS:
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
                          occurred running TCP end port' |> +
                          %CHAR(&LOCALPORT) |> 'check. Most likely +
                          the selected port is not active') +
                          MSGTYPE(*ESCAPE)

             ENDPGM
