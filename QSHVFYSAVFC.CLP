             PGM        PARM(&FRMIFSSAVF &DSPSAVF &PRTSAVF &DLTTMPSAVF)

             DCL        VAR(&FRMIFSSAVF) TYPE(*CHAR) LEN(255)
             DCL        VAR(&JOBTYPE) TYPE(*CHAR) LEN(1)
             DCL        VAR(&DSPSAVF) TYPE(*CHAR) LEN(4)
             DCL        VAR(&PRTSAVF) TYPE(*CHAR) LEN(4)
             DCL        VAR(&DLTTMPSAVF) TYPE(*CHAR) LEN(4)

             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))

             /* Get batch/interactive */
             RTVJOBA    TYPE(&JOBTYPE)

             /* From IFS file name must be entered. */
             IF         COND(&FRMIFSSAVF *EQ ' ') THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('From +
                          IFS file name must be entered') +
                          MSGTYPE(*ESCAPE)
             ENDDO

             /* Check for existing IFS file.*/
             /* Bail out if not found.      */
             QSHONI/QSHIFSCHK FILNAM(&FRMIFSSAVF)
             /* File not found. Nothing to do */
             MONMSG     MSGID(CPF9898) EXEC(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('IFS +
                          savf file' |> &FRMIFSSAVF |> 'not found. +
                          Save file verify cancelled') MSGTYPE(*ESCAPE)
             ENDDO

             /* File was found, continue */
             MONMSG     MSGID(CPF9897) EXEC(DO)
             ENDDO

             /* Create the save file if not found in QTEMP */
             CHKOBJ     OBJ(QTEMP/TMPSAVF) OBJTYPE(*FILE)
             MONMSG     MSGID(CPF9801) EXEC(DO)
             CRTSAVF    FILE(QTEMP/TMPSAVF) TEXT('Temporary Save File')
             ENDDO

             /* Clear the save file */
        /*   CLRSAVF    FILE(QTEMP/TMPSAVF)   */

             /* Save message to screen as status msg if interactive */
             IF         COND(&JOBTYPE *EQ '1') THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Save +
                          file being copied from IFS save file' |> +
                          &FRMIFSSAVF) TOPGMQ(*EXT) MSGTYPE(*STATUS)
             ENDDO

             /* Copy the current library save file from IFS file  */
             /* to the save file.                                 */
             /* We use CVTDTA *NONE so no data conversion occurs. */
             /* The result is a save file in QTEMP                */
             CPYFRMSTMF FROMSTMF(&FRMIFSSAVF) +
                          TOMBR('/QSYS.LIB/QTEMP.LIB/TMPSAVF.FILE'+
                          ) MBROPT(*REPLACE) CVTDTA(*NONE)

             /* Display the save file contents */
             IF         COND(&DSPSAVF *EQ *YES) THEN(DO)
             DSPSAVF    FILE(QTEMP/TMPSAVF) OUTPUT(*)
             ENDDO
             /* Print the save file contents */
             IF         COND(&PRTSAVF *EQ *YES) THEN(DO)
             OVRPRTF    FILE(QPSRODSP) HOLD(*YES) OVRSCOPE(*ACTGRPDFN)
             DSPSAVF    FILE(QTEMP/TMPSAVF) OUTPUT(*PRINT)
             DLTOVR     FILE(QPSRODSP) LVL(*ACTGRPDFN)
             ENDDO

             /* Delete temp save file after display */
             IF         COND(&DLTTMPSAVF *EQ *YES) THEN(DO)
             CLRSAVF    FILE(QTEMP/TMPSAVF)
             DLTF       FILE(QTEMP/TMPSAVF)
             ENDDO

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('IFS +
                          save file' |> &FRMIFSSAVF |> 'was copied +
                          and verified successfully. File appears +
                          to be valid') MSGTYPE(*COMP)

             RETURN

ERRORS:
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
                          occured while verifying IFS save file ' +
                          |> &FRMIFSSAVF |> '. Check the job log') +
                          MSGTYPE(*ESCAPE)

             ENDPGM
