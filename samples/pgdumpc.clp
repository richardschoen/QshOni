/* Text: Backup Postgres Database via pg_dump to tar format  */
/* Postgres reference link: */
/* https://www.tecmint.com/backup-and-restore-postgresql-database/   */
             PGM        PARM(&DATABASE &OUTPUTFILE &FORMAT &REPLACE)

             DCL        VAR(&CMDLINE) TYPE(*CHAR) LEN(1000)
             DCL        VAR(&CMDLINEVFY) TYPE(*CHAR) LEN(1000)
             DCL        VAR(&DATABASE) TYPE(*CHAR) LEN(255)
             DCL        VAR(&OUTPUTFILE) TYPE(*CHAR) LEN(255)
             DCL        VAR(&FORMAT) TYPE(*CHAR) LEN(10)
             DCL        VAR(&REPLACE) TYPE(*CHAR) LEN(4)

             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))

/* Build pg_dump command line for selected database dump */
             CHGVAR     VAR(&CMDLINE) +
                          VALUE('/QOpenSys/pkgs/bin/pg_dump -F' |> +
                          &FORMAT |> &DATABASE |> '>' |> &OUTPUTFILE)

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
             QSHONI/QSHBASH CMDLINE(&CMDLINE) SETPKGPATH(*YES) +
                          DSPSTDOUT(*YES) PRTSPLF(PGDUMPC) +
                          PRTTXT('Backup database via pg_dump')

/* Run tar command to verify backup tar file integrity */
             QSHONI/QSHBASH CMDLINE(&CMDLINEVFY) SETPKGPATH(*YES) +
                          DSPSTDOUT(*YES) PRTSPLF(PGDUMPVFY) +
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
