             PGM        PARM(&USER &CRTPROFILE &CRTBASHPRF +
                          &CRTBASHRC &REPLACE)

             DCL        VAR(&REPLACE) TYPE(*CHAR) LEN(4)
             DCL        VAR(&CRTPROFILE) TYPE(*CHAR) LEN(4)
             DCL        VAR(&CRTBASHPRF) TYPE(*CHAR) LEN(4)
             DCL        VAR(&CRTBASHRC) TYPE(*CHAR) LEN(4)
             DCL        VAR(&USER) TYPE(*CHAR) LEN(10)
             DCL        VAR(&RTNUSERID) TYPE(*CHAR) LEN(10)
             DCL        VAR(&USERLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&HOMEDIR) TYPE(*CHAR) LEN(255)
             DCL        VAR(&PROFILE) TYPE(*CHAR) LEN(255)
             DCL        VAR(&BASHRC) TYPE(*CHAR) LEN(255)
             DCL        VAR(&BASHPROF) TYPE(*CHAR) LEN(255)
             DCL        VAR(&PASSWORD) TYPE(*CHAR) LEN(10)
             DCL        VAR(&FOUND) TYPE(*CHAR) LEN(4)
             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))

/* At least 1 option must be *YES */
             IF         COND(&CRTPROFILE *NE *YES *AND &CRTBASHPRF +
                          *NE *YES *AND &CRTBASHRC *NE *YES) THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('At +
                          least one copy option must be set to +
                          *YES. Profile copy cancelled') +
                          MSGTYPE(*ESCAPE)
             ENDDO

/* Does selected user profile exist ? */
             RTVUSRPRF  USRPRF(&USER) RTNUSRPRF(&RTNUSERID)
             MONMSG     MSGID(CPF0000) EXEC(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('User +
                          profile' |> &USER |> 'may not exist or +
                          you cannot access it. Profile copy +
                          cancelled') MSGTYPE(*ESCAPE)
             ENDDO

/* Set user info for user home dir */
/* Currently: /home/USERID assumed for home dir path */
             CHGVAR     VAR(&USERLIB) VALUE(&USER)
             CHGVAR     VAR(&HOMEDIR) VALUE('/home/' |< &USER)
             CHGVAR     VAR(&PROFILE) VALUE(&HOMEDIR |< '/.profile')
             CHGVAR     VAR(&BASHRC) VALUE(&HOMEDIR |< '/.bashrc')
             CHGVAR     VAR(&BASHPROF) VALUE(&HOMEDIR |< +
                          '/.bash_profile')

/* Create home dir for new user if not found */
             MKDIR      DIR(&HOMEDIR) DTAAUT(*RWX) OBJAUT(*ALL)
             MONMSG     MSGID(CPF0000)

/* TODO - disable home dir auth change for now. Needs more testing */
/*           CHGOWN     OBJ(&HOMEDIR) NEWOWN(&USER) RVKOLDAUT(*YES) +
                          SUBTREE(*NONE)                               */

/*           CHGAUT     OBJ(&HOMEDIR) USER(&USER) DTAAUT(*RWX) +
                          OBJAUT(*ALL)                                 */

/*           CHGAUT     OBJ(&HOMEDIR) USER(*PUBLIC) DTAAUT(*RX) +
                          OBJAUT(*ALL)                                 */

/*-------------------------------------------------------------*/

/* Are we creating .profile ? */
             IF         COND(&CRTPROFILE *EQ *YES) THEN(DO)

/* IF .profile exists and replace <> *YES, bail out */
             QSHIFSCHK  FILNAM(&PROFILE)
             MONMSG     MSGID(CPF9898) EXEC(DO)
             ENDDO
             MONMSG     MSGID(CPF9897) EXEC(DO)
             IF         COND(&REPLACE *EQ *NO) THEN(SNDPGMMSG +
                          MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA(&PROFILE |> 'file already exists +
                          and replace is *NO. Profile copy +
                          cancelled') MSGTYPE(*ESCAPE))
             ENDDO

/* Copy QShell .profile and set auth */
/* Copy with line feeds and code page 819 */
             CPYTOSTMF  +
                          FROMMBR('/QSYS.LIB/QSHONI.LIB/SOURCE.FILE/Q+
                          SHPROFILE.MBR') TOSTMF(&PROFILE) +
                          STMFOPT(*REPLACE) CVTDTA(*AUTO) +
                          ENDLINFMT(*LF) AUT(*INDIR) STMFCODPAG(819)

             CHGOWN     OBJ(&PROFILE) NEWOWN(&USER) RVKOLDAUT(*YES) +
                          SUBTREE(*NONE)

             CHGAUT     OBJ(&PROFILE) USER(&USER) DTAAUT(*RWX) +
                          OBJAUT(*ALL) SUBTREE(*NONE)

             CHGAUT     OBJ(&PROFILE) USER(*PUBLIC) DTAAUT(*RX) +
                          OBJAUT(*ALL) SUBTREE(*NONE)

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA(&PROFILE +
                          |> 'file was copied/created') MSGTYPE(*DIAG)

             ENDDO /* Creating .profile ? */

/*-------------------------------------------------------------*/

/* Are we creating .bash_profile ? */
             IF         COND(&CRTBASHPRF *EQ *YES) THEN(DO)

/* IF .bash_profile exists and replace <> *YES, bail out */
             QSHIFSCHK  FILNAM(&BASHPROF)
             MONMSG     MSGID(CPF9898) EXEC(DO)
             ENDDO
             MONMSG     MSGID(CPF9897) EXEC(DO)
             IF         COND(&REPLACE *EQ *NO) THEN(SNDPGMMSG +
                          MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA(&BASHPROF|> 'file already exists +
                          and replace is *NO. Profile copy +
                          cancelled') MSGTYPE(*ESCAPE))
             ENDDO

/* Copy .bash_profile and set auth */
/* Copy with line feeds and code page 819 */
             CPYTOSTMF  +
                          FROMMBR('/QSYS.LIB/QSHONI.LIB/SOURCE.FILE/Q+
                          SHBASHPRF.MBR') TOSTMF(&BASHPROF) +
                          STMFOPT(*REPLACE) CVTDTA(*AUTO) +
                          ENDLINFMT(*LF) AUT(*INDIR) STMFCODPAG(819)

             CHGOWN     OBJ(&BASHPROF) NEWOWN(&USER) RVKOLDAUT(*YES) +
                          SUBTREE(*NONE)

             CHGAUT     OBJ(&BASHPROF) USER(&USER) DTAAUT(*RWX) +
                          OBJAUT(*NONE)

             CHGAUT     OBJ(&BASHPROF) USER(*PUBLIC) DTAAUT(*RX) +
                          OBJAUT(*NONE)

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA(&BASHPROF +
                          |> 'file was copied/created') MSGTYPE(*DIAG)

             ENDDO /* Creating .bash_profile ? */

/*-------------------------------------------------------------*/

/* Are we creating .bashrc ? */
             IF         COND(&CRTBASHRC *EQ *YES) THEN(DO)

/* IF .bashrc exists and replace <> *YES, bail out */
             QSHIFSCHK  FILNAM(&BASHRC)
             MONMSG     MSGID(CPF9898) EXEC(DO)
             ENDDO
             MONMSG     MSGID(CPF9897) EXEC(DO)
             IF         COND(&REPLACE *EQ *NO) THEN(SNDPGMMSG +
                          MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA(&BASHRC |> 'file already exists +
                          and replace is *NO. Profile copy +
                          cancelled') MSGTYPE(*ESCAPE))
             ENDDO

/* Copy .bashrc and set auth */
/* Copy with line feeds and code page 819 */
             CPYTOSTMF  +
                          FROMMBR('/QSYS.LIB/QSHONI.LIB/SOURCE.FILE/Q+
                          SHBASHRC.MBR') TOSTMF(&BASHRC) +
                          STMFOPT(*REPLACE) CVTDTA(*AUTO) +
                          ENDLINFMT(*LF) AUT(*INDIR) STMFCODPAG(819)

             CHGOWN     OBJ(&BASHRC) NEWOWN(&USER) RVKOLDAUT(*YES) +
                          SUBTREE(*NONE)

             CHGAUT     OBJ(&BASHRC) USER(&USER) DTAAUT(*RWX) +
                          OBJAUT(*NONE)

             CHGAUT     OBJ(&BASHRC) USER(*PUBLIC) DTAAUT(*RX) +
                          OBJAUT(*NONE)

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA(&BASHRC +
                          |> 'file was copied/created') MSGTYPE(*DIAG)

             ENDDO /* Creating .bashrc ? */

/*-------------------------------------------------------------*/

             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA('QShell/PASE profile files were +
                          created successfully for user' |> &USER) +
                          MSGTYPE(*COMP)

             RETURN

ERRORS:
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Errors +
                          occurred while creating QShell/PASE profile +
                          files for user.' |> &USER |> 'Check +
                          joblog') MSGTYPE(*ESCAPE)
