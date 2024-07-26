             PGM        PARM(&OBJECTS &TOIFSFILE &IFSPREFIX &SUBTREE +
                          &REPLACE &TGTRLS &UPDHST &PRECHK &SAVACT +
                          &DTACPR &DLTTMPSAVF &PROMPT)

             DCL        VAR(&PROMPT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&IFSPREFIX) TYPE(*CHAR) LEN(100)
             DCL        VAR(&DLTTMPSAVF) TYPE(*CHAR) LEN(4)
             DCL        VAR(&SIZE) TYPE(*DEC) LEN(15 0)
             DCL        VAR(&ALLOCSIZE) TYPE(*DEC) LEN(15 0)
             DCL        VAR(&OBJECTS) TYPE(*CHAR) LEN(255)
             DCL        VAR(&TOIFSFILE) TYPE(*CHAR) LEN(255)
             DCL        VAR(&SUBTREE) TYPE(*CHAR) LEN(5)
             DCL        VAR(&REPLACE) TYPE(*CHAR) LEN(4)
             DCL        VAR(&TGTRLS) TYPE(*CHAR) LEN(10)
             DCL        VAR(&JOBTYPE) TYPE(*CHAR) LEN(1)
             DCL        VAR(&JOBTYPE) TYPE(*CHAR) LEN(1)
             DCL        VAR(&UPDHST) TYPE(*CHAR) LEN(4)
             DCL        VAR(&PRECHK) TYPE(*CHAR) LEN(4)
             DCL        VAR(&SAVACT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&DTACPR) TYPE(*CHAR) LEN(7)
             DCL        VAR(&UPDHST) TYPE(*CHAR) LEN(4)
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

             /* If special values used, build new IFS output path.  */
             IF         COND(&TOIFSFILE *EQ *DATETIME *OR &TOIFSFILE *EQ +
                          *DATE) THEN(DO)

             /* Create temp output directory data area if not found */
             CHKOBJ     OBJ(QSHONI/SAVFDIR) OBJTYPE(*DTAARA)
             MONMSG     MSGID(CPF9801) EXEC(DO)
             CRTDTAARA  DTAARA(QSHONI/SAVFDIR) TYPE(*CHAR) LEN(255) +
                          VALUE('/tmp/savfqsh') TEXT('Path to save +
                          file IFS output')
             ENDDO

             /* Get temp output directory */
             RTVDTAARA  DTAARA(QSHONI/SAVFDIR *ALL) RTNVAR(&SAVFDIR)
             IF         COND(&SAVFDIR *EQ ' ') THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Save +
                          file output directory must be set in data +
                          area QSHONI/SAVFDIR') MSGTYPE(*ESCAPE)
             ENDDO

             /* Create temp dir if not found */
             QSHONI/QSHIFSCHK FILNAM(&SAVFDIR)

             /* Dir not found. Create it. */
             MONMSG     MSGID(CPF9898) EXEC(DO)
             MKDIR      DIR(&SAVFDIR) DTAAUT(*RWX) OBJAUT(*ALL)
             ENDDO

             /* Dir was found, do nothing special */
             MONMSG     MSGID(CPF9897) EXEC(DO)
             ENDDO

             ENDDO

             /* Build output file name if special keywords used */
             IF         COND(&TOIFSFILE *EQ *DATETIME) THEN(DO)
             CHGVAR     VAR(&TOIFSFILE) VALUE(&SAVFDIR |< '/' |< +
                          &IFSPREFIX |< '_' |< &QDATE10 |< '_' |< +
                          &QTIME |< '.savf')
             ENDDO
             IF         COND(&TOIFSFILE *EQ *DATE) THEN(DO)
             CHGVAR     VAR(&TOIFSFILE) VALUE(&SAVFDIR |< '/' |< +
                          &IFSPREFIX |< '_' |< &QDATE10 |< '.savf')
             ENDDO

             /* Check for existing IFS file.*/
             /* Bail out if not replacing.  */
             QSHONI/QSHIFSCHK FILNAM(&TOIFSFILE)
             /* File not found. Nothing to do */
             MONMSG     MSGID(CPF9898) EXEC(DO)
             ENDDO

             /* File was found, delete if replacing */
             MONMSG     MSGID(CPF9897) EXEC(DO)

             IF         COND(&REPLACE *EQ *YES) THEN(DO)
             ERASE      OBJLNK(&TOIFSFILE)
             ENDDO

             IF         COND(&REPLACE *NE *YES) THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('IFS +
                          file' |> &TOIFSFILE |> 'already exists +
                          and replace not selected. IFS object save +
                          cancelled') MSGTYPE(*ESCAPE)
             ENDDO

             ENDDO  /* ENDDO special value check */

             /* Create the save file if not found in QTEMP */
             CHKOBJ     OBJ(QTEMP/TEMPBACKUP) OBJTYPE(*FILE)
             MONMSG     MSGID(CPF9801) EXEC(DO)
             CRTSAVF    FILE(QTEMP/TEMPBACKUP) TEXT('Temporary backup')
             ENDDO

             /* Clear the save file */
             CLRSAVF    FILE(QTEMP/TEMPBACKUP)

             /* Save message to screen as status msg if interactive */
             IF         COND(&JOBTYPE *EQ '1') THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('IFS +
                          objects' |> &OBJECTS |> 'being saved to +
                          IFS file' |> &TOIFSFILE) TOPGMQ(*EXT) +
                          MSGTYPE(*STATUS)
             ENDDO

             /* Save the IFS files */
             IF         COND(&PROMPT *NE *YES) THEN(DO)
             SAV        DEV('/QSYS.LIB/QTEMP.LIB/TEMPBACKUP.FILE') +
                          OBJ((&OBJECTS *INCLUDE)) +
                          SUBTREE(&SUBTREE) SAVACT(&SAVACT) +
                          PRECHK(&PRECHK) TGTRLS(&TGTRLS) +
                          UPDHST(&UPDHST) DTACPR(&DTACPR)
             ENDDO
             IF         COND(&PROMPT *EQ *YES) THEN(DO)
             ?          SAV +
                          DEV('/QSYS.LIB/QTEMP.LIB/TEMPBACKUP.FILE') +
                          ??OBJ((&OBJECTS *INCLUDE)) +
                          ??SUBTREE(&SUBTREE) ??SAVACT(&SAVACT) +
                          ??PRECHK(&PRECHK) ??TGTRLS(&TGTRLS) +
                          ??UPDHST(&UPDHST) ??DTACPR(&DTACPR)
             ENDDO

             /* Copy the current IFS obj save file to IFS file.   */
             /* We use CVTDTA *NONE so no data conversion occurs. */
             /* The result is a save file in the IFS.             */
             CPYTOSTMF  +
                          FROMMBR('/QSYS.LIB/QTEMP.LIB/TEMPBACKUP.FIL+
                          E') TOSTMF(&TOIFSFILE) STMFOPT(*REPLACE) +
                          CVTDTA(*NONE)

             /* Delete save file from QTEMP */
             IF         COND(&DLTTMPSAVF *EQ *YES) THEN(DO)
             DLTF       FILE(QTEMP/TEMPBACKUP)
             ENDDO

             /* Get IFS save file size */
             QSHONI/QSHIFSSIZ FILE(&TOIFSFILE) SIZE(&SIZE) +
                          ALLOCSIZE(&ALLOCSIZE) ESCONERROR(*YES)

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('IFS +
                          objects' |> &OBJECTS |> 'were saved to +
                          IFS file' |> &TOIFSFILE |> 'Size:' |< +
                          %CHAR(&SIZE) |> 'bytes') MSGTYPE(*COMP)
             RETURN

ERRORS:
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
                          occurred saving IFS files ' |> &OBJECTS +
                          |< 'to IFS file' |> &TOIFSFILE |> '. See +
                          the job log') MSGTYPE(*ESCAPE)

             ENDPGM
