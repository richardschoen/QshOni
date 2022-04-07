             CMD        PROMPT('Set Up Pase Profile for User')
             PARM       KWD(USER) TYPE(*CHAR) LEN(10) PROMPT('User +
                          profile')
             PARM       KWD(PROFILE) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) PROMPT('Create +
                          .profile for user')
             PARM       KWD(BASHPROFIL) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          PROMPT('Create .bash_profile for user')
             PARM       KWD(BASHRC) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) PROMPT('Create +
                          .bashrc for user')
             PARM       KWD(REPLACE) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Replace +
                          if found')
