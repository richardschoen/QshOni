/*----------------------------------------------------------*/
/* QSHIFSSCAC - Scan IFS file for values                    */
/*----------------------------------------------------------*/
             PGM        PARM(&IFSFILE &SCANFOR &EXACTMATCH +
                          &ENDLINFMT &DLTTMPFILE)

             DCL        VAR(&DLTTMPFILE) TYPE(*CHAR) LEN(4)
             DCL        VAR(&IFSFILE) TYPE(*CHAR) LEN(255)
             DCL        VAR(&SCANFOR) TYPE(*CHAR) LEN(2002)
             DCL        VAR(&EXACTMATCH) TYPE(*CHAR) LEN(4)
             DCL        VAR(&ENDLINFMT) TYPE(*CHAR) LEN(6)
             DCL        VAR(&RTNFOUND) TYPE(*CHAR) LEN(1)
             DCL        VAR(&RTNVAL) TYPE(*CHAR) LEN(100)

             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))

             /* Check for selected IFS file */
             QSHONI/QSHIFSCHK FILNAM(&IFSFILE)
             /* File not found */
             MONMSG     MSGID(CPF9898) EXEC(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('IFS +
                          file' |> &IFSFILE |> 'does not exist.') +
                          MSGTYPE(*ESCAPE)
             ENDDO
             /* File found */
             MONMSG     MSGID(CPF9897) EXEC(DO)
             ENDDO

             /* Create temporary PF to receive IFS file */
             CRTPF      FILE(QTEMP/TMPIFSFILE) RCDLEN(1000) +
                          TEXT('Temporary IFS Physical File Copy') +
                          OPTION(*NOLIST *NOSRC) MAXMBRS(*NOMAX) +
                          SIZE(*NOMAX)
             MONMSG     MSGID(CPF0000)
             /* Clear temp file before processing */
             CLRPFM     FILE(QTEMP/TMPIFSFILE)

             /* Copy IFS file contents to temp PF */
             CPYFRMSTMF FROMSTMF(&IFSFILE) +
                          TOMBR('/QSYS.LIB/QTEMP.LIB/TMPIFSFILE.FILE/+
                          TMPIFSFILE.MBR') MBROPT(*REPLACE) +
                          CVTDTA(*AUTO) ENDLINFMT(&ENDLINFMT)

             /* Call program to scan the log now */
             OVRDBF     FILE(STDOUTQSH) TOFILE(QTEMP/TMPIFSFILE)
             CALL       PGM(QSHIFSSCAR) PARM(&SCANFOR &EXACTMATCH +
                          &RTNFOUND &RTNVAL)
             DLTOVR     FILE(STDOUTQSH)

             /* Delete temp file if specified */
             IF         COND(&DLTTMPFILE *EQ *YES) THEN(DO)
             DLTF       FILE(QTEMP/TMPIFSFILE)
             ENDDO

             IF         COND(&RTNFOUND *EQ '1') THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Value' +
                          |> &RTNVAL |> 'was found in IFS file' |> +
                          &IFSFILE) MSGTYPE(*COMP)
             ENDDO
             IF         COND(&RTNFOUND *EQ '0') THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Value +
                          was NOT found in IFS file') +
                          MSGTYPE(*ESCAPE)
             ENDDO

             RETURN

ERRORS:
             /* Delete temp file if specified */
             IF         COND(&DLTTMPFILE *EQ *YES) THEN(DO)
             DLTF       FILE(QTEMP/TMPIFSFILE)
             MONMSG     MSGID(CPF0000)
             ENDDO

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
                          scanning for value in IFS file') +
                          MSGTYPE(*ESCAPE)
             ENDPGM
