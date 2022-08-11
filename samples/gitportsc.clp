/* Member name: GITPORTSC.CLP */
/* Source type: CLP */
/* Text: Check TCP Ports for POstgreSQL/GitBucket Servers */
/* Purpose: Check to see if selected ports are active which means servers up and running*/
             PGM


             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))

/* Make sure Postgres is running on port 5432 */
             QSHONI/QSHPORTCHK LOCALPORT(5432)
             MONMSG     MSGID(CPF9898) EXEC(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA('PostgreSQL server may not be +
                          running on port 5432') MSGTYPE(*ESCAPE)
             ENDDO
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA('PostgreSQL seems to be running on +
                          port 5432') MSGTYPE(*DIAG)

/* Make sure Gitbucket server is running on port 8080 */
             QSHONI/QSHPORTCHK LOCALPORT(8080)
             MONMSG     MSGID(CPF9898) EXEC(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA('GitBucket server may not be +
                          running on port 8080') MSGTYPE(*ESCAPE)
             ENDDO
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA('GitBucket seems to be running on +
                          port 8080') MSGTYPE(*DIAG)

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA('PostgreSQL (5432) and GitBucket +
                          (8080) seem to be running') MSGTYPE(*COMP)

             RETURN

ERRORS:
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
                          occurred during port checks. Check the +
                          joblog') MSGTYPE(*ESCAPE)

             ENDPGM
