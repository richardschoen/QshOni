             PGM        PARM(&OBJECTS &FRMIFSFILE &DLTTMPSAVF &PROMPT)

             DCL        VAR(&OBJECTS) TYPE(*CHAR) LEN(255)
             DCL        VAR(&PROMPT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&DLTTMPSAVF) TYPE(*CHAR) LEN(4)
             DCL        VAR(&FRMIFSFILE) TYPE(*CHAR) LEN(255)
             DCL        VAR(&REPLACE) TYPE(*CHAR) LEN(4)
             DCL        VAR(&JOBTYPE) TYPE(*CHAR) LEN(1)
             DCL        VAR(&QDATE) TYPE(*CHAR) LEN(6)
             DCL        VAR(&QTIME) TYPE(*CHAR) LEN(9)
             DCL        VAR(&QDATE10) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SAVFDIR) TYPE(*CHAR) LEN(255)

             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))

             /* Get batch/interactive */
             RTVJOBA    TYPE(&JOBTYPE)

             /* Get date info */
             RTVSYSVAL  SYSVAL(QDATE) RTNVAR(&QDATE)
             CVTDAT     DATE(&QDATE) TOVAR(&QDATE10) FROMFMT(*JOB) +
                          TOFMT(*YYMD) TOSEP(*NONE)
             RTVSYSVAL  SYSVAL(QTIME) RTNVAR(&QTIME)

             /* Check for existing IFS file.*/
             /* Bail out if not found.      */
             QSHONI/QSHIFSCHK FILNAM(&FRMIFSFILE)
             /* File not found. Nothing to do */
             MONMSG     MSGID(CPF9898) EXEC(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('IFS +
                          file' |> &FRMIFSFILE |> 'not found. +
                          Object restore cancelled') MSGTYPE(*ESCAPE)
             ENDDO

             /* File was found, continue */
             MONMSG     MSGID(CPF9897) EXEC(DO)
             ENDDO

             /* Create the save file if not found in QTEMP */
             CHKOBJ     OBJ(QTEMP/TMPRSTOBJ) OBJTYPE(*FILE)
             MONMSG     MSGID(CPF9801) EXEC(DO)
             CRTSAVF    FILE(QTEMP/TMPRSTOBJ) TEXT('Temporary restore')
             ENDDO

             /* Clear the save file */
             CLRSAVF    FILE(QTEMP/TMPRSTOBJ)

             /* Save message to screen as status msg if interactive */
             IF         COND(&JOBTYPE *EQ '1') THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('IFS +
                          objects' |> &OBJECTS |> 'being restored +
                          from IFS save file' |> &FRMIFSFILE) +
                          TOPGMQ(*EXT) MSGTYPE(*STATUS)
             ENDDO

             /* Copy the current library save file from IFS file  */
             /* to the save file.                                 */
             /* We use CVTDTA *NONE so no data conversion occurs. */
             /* The result is a save file in QTEMP                */
             CPYFRMSTMF FROMSTMF(&FRMIFSFILE) +
                          TOMBR('/QSYS.LIB/QTEMP.LIB/TMPRSTOBJ.FILE'+
                          ) MBROPT(*REPLACE) CVTDTA(*NONE)

             /* Restore the objects from save file */
             IF         COND(&PROMPT *NE *YES) THEN(DO)
             RST        DEV('/QSYS.LIB/QTEMP.LIB/TMPRSTOBJ.FILE') +
                          OBJ((&OBJECTS *INCLUDE *SAME)) +
                          SUBTREE(*ALL) CRTPRNDIR(*YES) +
                          OPTION(*ALL) ALWOBJDIF(*ALL) +
                          FRCOBJCVN(*SYSVAL) PVTAUT(*NO) STRJRN(*YES)
             ENDDO
             IF         COND(&PROMPT *EQ *YES) THEN(DO)
          ?  RST      ??DEV('/QSYS.LIB/QTEMP.LIB/TMPRSTOBJ.FILE') +
                        ??OBJ((&OBJECTS *INCLUDE *SAME)) +
                        ??SUBTREE(*ALL) ??CRTPRNDIR(*YES) +
                        ??OPTION(*ALL) ??ALWOBJDIF(*ALL) +
                        ??FRCOBJCVN(*SYSVAL) +
                        ??PVTAUT(*NO) ??STRJRN(*YES)
             ENDDO

             /* Delete save file from QTEMP if selected   */
             /* Sometimes may want to leave it around for */
             /* testing and displaying the savf results.  */
             IF         COND(&DLTTMPSAVF *EQ *YES) THEN(DO)
             DLTF       FILE(QTEMP/TMPRSTOBJ)
             ENDDO

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Objects +
                          ' |> &OBJECTS |> 'restored from IFS save +
                          file') MSGTYPE(*COMP)

             RETURN

ERRORS:
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
                          occurred restoring IFS objects from IFS +
                          save file' |> &FRMIFSFILE |> '. Check the +
                          job log') MSGTYPE(*ESCAPE)

             ENDPGM
