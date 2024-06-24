/* Member name: PGDUMPC  */
/* Source type: CLP */
/* Text: Backup Postgres Database via pg_dump to tar format */
/* Postgres reference link: */
/* https://www.tecmint.com/backup-and-restore-postgresql-database/   */
             PGM        PARM(&DATABASE &OUTPUTFILE &FORMAT &OPTIONS +
                          &PROMPT &REPLACE &DSPSTDOUT &LOGSTDOUT +
                          &PRTSTDOUT)

             DCL        VAR(&PGBACKDFT) TYPE(*CHAR) LEN(255) +
                          VALUE('/tmp/pgbackup')
             DCL        VAR(&PGBACKDIR) TYPE(*CHAR) LEN(255)
             DCL        VAR(&QDATE) TYPE(*CHAR) LEN(6)
             DCL        VAR(&QDATE10) TYPE(*CHAR) LEN(10)
             DCL        VAR(&QTIME) TYPE(*CHAR) LEN(9)
             DCL        VAR(&CMDLINE) TYPE(*CHAR) LEN(1000)
             DCL        VAR(&CMDLINEVFY) TYPE(*CHAR) LEN(1000)
             DCL        VAR(&DATABASE) TYPE(*CHAR) LEN(255)
             DCL        VAR(&OUTPUTFILE) TYPE(*CHAR) LEN(255)
             DCL        VAR(&FORMAT) TYPE(*CHAR) LEN(10)
             DCL        VAR(&OPTIONS) TYPE(*CHAR) LEN(100)
             DCL        VAR(&REPLACE) TYPE(*CHAR) LEN(4)
             DCL        VAR(&PROMPT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&DSPSTDOUT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&LOGSTDOUT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&PRTSTDOUT) TYPE(*CHAR) LEN(4)

             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))

/* See if backup dir data area exists */
/* If not, set default PGBACKUP dir   */
             /* Check for the data area */
             CHKOBJ     OBJ(QGPL/PGBACKDIR) OBJTYPE(*DTAARA)
             /* Create data area if not found */
             MONMSG     MSGID(CPF9801) EXEC(DO)
             CRTDTAARA  DTAARA(QGPL/PGBACKDIR) TYPE(*CHAR) LEN(255) +
                          VALUE(&PGBACKDFT) TEXT('PostgreSQL +
                          default backup to directory') AUT(*ALL)
             ENDDO

             /* Retrieve data area value for PGBACKDIR */
             RTVDTAARA  DTAARA(QGPL/PGBACKDIR *ALL) RTNVAR(&PGBACKDIR)

/* Make sure backup dir exists */
             QSHONI/QSHIFSCHK FILNAM(&PGBACKDIR)
             /* Not found, create it */
             MONMSG     MSGID(CPF9898) EXEC(DO)
             MKDIR      DIR(&PGBACKDIR) DTAAUT(*RWX) OBJAUT(*ALL)
             ENDDO
             /* Found. Do Nothing */
             MONMSG     MSGID(CPF9897) EXEC(DO)
             ENDDO

/* Get date/time info */
             RTVSYSVAL  SYSVAL(QDATE) RTNVAR(&QDATE)
             CVTDAT     DATE(&QDATE) TOVAR(&QDATE10) FROMFMT(*JOB) +
                          TOFMT(*YYMD) TOSEP(*NONE)
             RTVSYSVAL  SYSVAL(QTIME) RTNVAR(&QTIME)

/* Set output file if special keywords specified */
             /* Check for *DBTEMPDATETIME passed as output file */
             IF         COND(&OUTPUTFILE *EQ *DBTEMPDATETIME) THEN(DO)
             /* Bail if no data area value */
             IF         COND(&PGBACKDIR *EQ ' ') THEN(SNDPGMMSG +
                          MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA('PGBACKDIR data area is empty. +
                          Please set a value') MSGTYPE(*ESCAPE))

             CHGVAR     VAR(&OUTPUTFILE) VALUE(&PGBACKDIR |< '/' |< +
                          &DATABASE |< '-' |< &QDATE10 |< '-' |< +
                          &QTIME |< '.tar')
             ENDDO

             /* Check for *DBTEMPDATE passed as output file */
             IF         COND(&OUTPUTFILE *EQ *DBTEMPDATE) THEN(DO)

             /* Bail if no data area value */
             IF         COND(&PGBACKDIR *EQ ' ') THEN(SNDPGMMSG +
                          MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA('PGBACKDIR data area is empty. +
                          Please set a value') MSGTYPE(*ESCAPE))

             CHGVAR     VAR(&OUTPUTFILE) VALUE(&PGBACKDIR |< '/' |< +
                          &DATABASE |< '-' |< &QDATE10 |< '.tar')

             ENDDO

/* Build pg_dump command line for selected database dump */
             CHGVAR     VAR(&CMDLINE) +
                          VALUE('/QOpenSys/pkgs/bin/pg_dump -F' |> +
                          &FORMAT |> '-d' |> &DATABASE |> &OPTIONS +
                          |> '>' |> &OUTPUTFILE)

/* Build tar verify command line for selected database dump */
             CHGVAR     VAR(&CMDLINEVFY) VALUE('/QOpenSys/pkgs/bin/tar +
                          -tvf' |> &OUTPUTFILE)

/* Make sure Postgres dump file does not exist */
             QSHONI/QSHIFSCHK FILNAM(&OUTPUTFILE)
             /* Not found. Do nothing */
             MONMSG     MSGID(CPF9898) EXEC(DO)
             ENDDO
             /* Found. See if we want to replace */
             MONMSG     MSGID(CPF9897) EXEC(DO)
             IF         COND(&REPLACE *EQ *YES) THEN(DO)
             ERASE      OBJLNK(&OUTPUTFILE)
             ENDDO
             IF         COND(&REPLACE *NE *YES) THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Output +
                          file' |> &OUTPUTFILE |> 'already exists +
                          and replace not selected. Postgres +
                          pg_dump cancelled') MSGTYPE(*ESCAPE)
             ENDDO
             ENDDO

/* Run the pg_dump to backup database                  */
/* Use QSHBASH because QSHEXEC causes tar file         */
/* to get created with CCSID 37 and archive is invalid */
/* Possibly an issue with /QOpenSys/usr/bin/tar        */
/* being used instead of /QOpenSys/pkgs/bin/tar        */
/* Just using QSHBASH seems to resolve the issue.      */

             IF         COND(&PROMPT *EQ *YES) THEN(DO)
             ?          QSHONI/QSHBASH ??CMDLINE(&CMDLINE) +
                          SETPKGPATH(*YES) DSPSTDOUT(&DSPSTDOUT) +
                          LOGSTDOUT(&LOGSTDOUT) +
                          PRTSTDOUT(&PRTSTDOUT) PRTSPLF(PGDUMPC) +
                          PRTTXT('Backup database via pg_dump')
             ENDDO
             IF         COND(&PROMPT *NE *YES) THEN(DO)
             QSHONI/QSHBASH CMDLINE(&CMDLINE) SETPKGPATH(*YES) +
                          DSPSTDOUT(&DSPSTDOUT) +
                          LOGSTDOUT(&LOGSTDOUT) +
                          PRTSTDOUT(&PRTSTDOUT) PRTSPLF(PGDUMPC) +
                          PRTTXT('Backup database via pg_dump')
             ENDDO

/* Run tar command to verify backup tar file integrity */
             QSHONI/QSHBASH CMDLINE(&CMDLINEVFY) SETPKGPATH(*YES) +
                          DSPSTDOUT(&DSPSTDOUT) +
                          LOGSTDOUT(&LOGSTDOUT) +
                          PRTSTDOUT(&PRTSTDOUT) PRTSPLF(PGDUMPVFY) +
                          PRTTXT('Verify pg_dump tar file')

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA('Postgres database' |> &DATABASE +
                          |> 'was dumped to' |> &OUTPUTFILE |> 'and +
                          verified successfully') MSGTYPE(*COMP)

             RETURN

ERRORS:
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
                          occurred during Postgres pg_dump and +
                          verify. Check the joblog') MSGTYPE(*ESCAPE)

             ENDPGM
