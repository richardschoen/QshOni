             PGM        PARM(&LIBRARY &RSTLIB &CLRLIB &FRMIFSFILE +
                          &OPTION &MBROPT &ALWOBJDIF &DLTTMPSAVF +
                          &PROMPT)

             DCL        VAR(&OPTION) TYPE(*CHAR) LEN(10)
             DCL        VAR(&MBROPT) TYPE(*CHAR) LEN(10)
             DCL        VAR(&ALWOBJDIF) TYPE(*CHAR) LEN(11)
             DCL        VAR(&RSTLIBTMP) TYPE(*CHAR) LEN(10)
             DCL        VAR(&RSTLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&LIBEXISTS) TYPE(*CHAR) LEN(1) VALUE('1')
             DCL        VAR(&CLRLIB) TYPE(*CHAR) LEN(4)
             DCL        VAR(&PROMPT) TYPE(*CHAR) LEN(4)
             DCL        VAR(&DLTTMPSAVF) TYPE(*CHAR) LEN(4)
             DCL        VAR(&LIBRARY) TYPE(*CHAR) LEN(10)
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

             /* From IFS file name must be entered. */
             IF         COND(&FRMIFSFILE *EQ ' ') THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('From +
                          IFS file name must be entered') +
                          MSGTYPE(*ESCAPE)
             ENDDO

             /* Check for existing IFS file.*/
             /* Bail out if not found.      */
             QSHONI/QSHIFSCHK FILNAM(&FRMIFSFILE)
             /* File not found. Nothing to do */
             MONMSG     MSGID(CPF9898) EXEC(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('IFS +
                          file' |> &FRMIFSFILE |> 'not found. +
                          Library restore cancelled') MSGTYPE(*ESCAPE)
             ENDDO

             /* File was found, continue */
             MONMSG     MSGID(CPF9897) EXEC(DO)
             ENDDO

             /* See if restore to library exists */
             /* If RSTLIB set, restore to selected lib */
             IF         COND(&RSTLIB *NE *SAVLIB) THEN(CHGVAR +
                          VAR(&RSTLIBTMP) VALUE(&RSTLIB))
             /* Otherwise restore to original library */
             ELSE       CMD(CHGVAR VAR(&RSTLIBTMP) VALUE(&LIBRARY))

             CHKOBJ     OBJ(QSYS/&RSTLIBTMP) OBJTYPE(*LIB)
             MONMSG     MSGID(CPF0000) EXEC(DO)
             CHGVAR     VAR(&LIBEXISTS) VALUE('0')
             ENDDO

             /* Clear library if selected and found */
             IF         COND(&LIBEXISTS *EQ '1' *AND &CLRLIB *EQ +
                          *YES) THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA('Clearing existing restore to +
                          library' |> &RSTLIBTMP |> 'before +
                          restore') TOPGMQ(*SAME) MSGTYPE(*DIAG)
             CLRLIB     LIB(&RSTLIBTMP)
             ENDDO

             /* Create the save file if not found in QTEMP */
             CHKOBJ     OBJ(QTEMP/TMPRSTLIB) OBJTYPE(*FILE)
             MONMSG     MSGID(CPF9801) EXEC(DO)
             CRTSAVF    FILE(QTEMP/TMPRSTLIB) TEXT('Temporary restore')
             ENDDO

             /* Clear the save file */
             CLRSAVF    FILE(QTEMP/TMPRSTLIB)

             /* Save message to screen as status msg if interactive */
             IF         COND(&JOBTYPE *EQ '1') THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA('Library' |> &LIBRARY |> 'being +
                          restored from IFS save file' |> +
                          &FRMIFSFILE) TOPGMQ(*EXT) MSGTYPE(*STATUS)
             ENDDO

             /* Copy the current library save file from IFS file  */
             /* to the save file.                                 */
             /* We use CVTDTA *NONE so no data conversion occurs. */
             /* The result is a save file in QTEMP                */
             CPYFRMSTMF FROMSTMF(&FRMIFSFILE) +
                          TOMBR('/QSYS.LIB/QTEMP.LIB/TMPRSTLIB.FILE'+
                          ) MBROPT(*REPLACE) CVTDTA(*NONE)

             /* Restore the library from save file */
             IF         COND(&PROMPT *NE *YES) THEN(DO)
             RSTLIB     SAVLIB(&LIBRARY) DEV(*SAVF) +
                          SAVF(QTEMP/TMPRSTLIB) OPTION(*ALL) +
                          MBROPT(*ALL) SPLFDTA(*NEW) +
                          ALWOBJDIF(*ALL) RSTLIB(&RSTLIB)
             ENDDO
             IF         COND(&PROMPT *EQ *YES) THEN(DO)
             ?          RSTLIB SAVLIB(&LIBRARY) ??DEV(*SAVF) +
                          ??SAVF(QTEMP/TMPRSTLIB) ??OMITLIB(*NONE) +
                          ??MBROPT(&MBROPT) ??DFRID(*DFT) +
                          ??OPTION(&OPTION) +
                          ??SPLFDTA(*NEW) PVTAUT(*NO) +
                          ??STRJRN(*YES) ??ALWOBJDIF(&ALWOBJDIF) +
                          ??FRCOBJCVN(*SYSVAL) ??RSTLIB(&RSTLIB) +
                          ??RSTASPDEV(*SAVASPDEV) ??RSTASP(*SAVASP) +
                          ??OUTPUT(*NONE) ??OMITOBJ((*NONE)) +
                          ??SELECT((*INCLUDE *ALL *ALL *ALL *ALL))
             ENDDO

             /* Delete save file from QTEMP if selected   */
             /* Sometimes may want to leave it around for */
             /* testing and displaying the savf results.  */
             IF         COND(&DLTTMPSAVF *EQ *YES) THEN(DO)
             DLTF       FILE(QTEMP/TMPRSTLIB)
             ENDDO

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Library +
                          ' |> &LIBRARY |> 'restored from IFS save +
                          file' |> &FRMIFSFILE |> 'to library' |> +
                          &RSTLIB) MSGTYPE(*COMP)

             RETURN

ERRORS:
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
                          occurred restoring Library ' |> &LIBRARY +
                          |> 'from IFS save file' |> &FRMIFSFILE |> +
                          '. Check the job log') MSGTYPE(*ESCAPE)

             ENDPGM
