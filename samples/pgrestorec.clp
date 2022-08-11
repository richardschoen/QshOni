/* Member name: PGRESTOREC */
/* Source type: CLP */
/* Text: Restore Postgres Database via pg_restore */
/* Postgres reference link: */
/* https://www.tecmint.com/backup-and-restore-postgresql-database/   */
             PGM        PARM(&DATABASE &INPUTFILE &OPTIONS &PROMPT)

             DCL        VAR(&CMDLINE) TYPE(*CHAR) LEN(1000)
             DCL        VAR(&DATABASE) TYPE(*CHAR) LEN(255)
             DCL        VAR(&INPUTFILE) TYPE(*CHAR) LEN(255)
             DCL        VAR(&OPTIONS) TYPE(*CHAR) LEN(100)
             DCL        VAR(&PROMPT) TYPE(*CHAR) LEN(4)

             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))

/* Build pg_restore command line for selected database restore */
             CHGVAR     VAR(&CMDLINE) +
                          VALUE('/QOpenSys/pkgs/bin/pg_restore' |> +
                          &OPTIONS |> '-d' |> &DATABASE |> ' ' |> +
                          &INPUTFILE)

/* Make sure Postgres dump file exists for restore */
             QSHONI/QSHIFSCHK FILNAM(&INPUTFILE)
             /* Not found. Bail out */
             MONMSG     MSGID(CPF9898) EXEC(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Input +
                          Postgres backup file' |> &INPUTFILE |> +
                          'not found. Postgres pg_restore +
                          cancelled') MSGTYPE(*ESCAPE)
             ENDDO
             /* Found. All good */
             MONMSG     MSGID(CPF9897) EXEC(DO)
             ENDDO

/* Run the pg_restore to restore Postgres database from backup file           */
/* Use QSHBASH because of potential issues with CCSID 37 from raw QShell call */
             IF         COND(&PROMPT *EQ *YES) THEN(DO)
             ?          QSHONI/QSHBASH ??CMDLINE(&CMDLINE) +
                          ??SETPKGPATH(*YES) ??DSPSTDOUT(*YES) +
                          ??PRTSTDOUT(*YES) ??PRTSPLF(PGRESTOREC)
             ENDDO
             IF         COND(&PROMPT *NE *YES) THEN(DO)
             QSHONI/QSHBASH CMDLINE(&CMDLINE) SETPKGPATH(*YES) +
                          DSPSTDOUT(*NO) PRTSTDOUT(*YES) +
                          PRTSPLF(PGRESTOREC)
             ENDDO

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA('Postgres database' |> &DATABASE +
                          |> 'was restored from' |> &INPUTFILE |> +
                          'successfully') MSGTYPE(*COMP)

             RETURN

ERRORS:
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
                          occurred during Postgres pg_restore. Check +
                          the joblog') MSGTYPE(*ESCAPE)

             ENDPGM
