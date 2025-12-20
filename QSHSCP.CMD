             CMD        PROMPT('Run SCP Command via QShell')
             PARM       KWD(CMDPFXPARM) TYPE(*CHAR) LEN(1000) MIN(1) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('Scp +
                          command prefix parms')
             PARM       KWD(KEYFILE) TYPE(*CHAR) LEN(255) MIN(1) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('SSH +
                          private key file')
             PARM       KWD(USER) TYPE(*CHAR) LEN(100) MIN(1) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('User name')
             PARM       KWD(HOST) TYPE(*CHAR) LEN(100) MIN(1) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('Host name')
             PARM       KWD(PORT) TYPE(*CHAR) LEN(5) DFT(22) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('TCP port')
             PARM       KWD(ACTION) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*SEND) VALUES(*SEND *RECEIVE) +
                          EXPR(*YES) CASE(*MONO) PROMPT('Transfer +
                          action')
             PARM       KWD(REPLLOCAL) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) EXPR(*YES) +
                          CASE(*MONO) PROMPT('Replace local file on +
                          receive')
             PARM       KWD(LOCALFILE) TYPE(*CHAR) LEN(255) MIN(1) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('Local file')
             PARM       KWD(REMOTEFILE) TYPE(*CHAR) LEN(255) MIN(1) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('Remote file')
             PARM       KWD(DEBUGCMD) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) EXPR(*YES) +
                          CASE(*MIXED) PROMPT('Debug PASE command +
                          line')
             PARM       KWD(SETPKGPATH) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('Set +
                          QOpenSys yum package path')
             PARM       KWD(DSPSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Display +
                          Standard Output Result')
             PARM       KWD(LOGSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Log +
                          standard output to job log')
             PARM       KWD(PRTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Print +
                          Standard Output Result')
             PARM       KWD(DLTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) PROMPT('Delete +
                          Standard Output Result')
             PARM       KWD(IFSSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Copy +
                          std output to IFS file')
             PARM       KWD(IFSFILE) TYPE(*CHAR) LEN(255) +
                          PROMPT('IFS file for stdout results')
             PARM       KWD(IFSOPT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*REPLACE) VALUES(*ADD *REPLACE *NONE) +
                          PROMPT('IFS file option')
             PARM       KWD(CCSID) TYPE(*CHAR) LEN(10) DFT(*SAME) +
                          SPCVAL((*SAME *SAME)) PROMPT('Coded +
                          character set ID for job')
             PARM       KWD(PRTSPLF) TYPE(*CHAR) LEN(10) +
                          DFT(QSHSCPLOG) PROMPT('Print stdout +
                          spool file')
             PARM       KWD(PRTUSRDTA) TYPE(*CHAR) LEN(10) +
                          DFT(*NONE) SPCVAL((*NONE ' ')) +
                          PROMPT('Print stdout user data')
             PARM       KWD(PRTTXT) TYPE(*CHAR) LEN(30) DFT(*NONE) +
                          SPCVAL((*NONE ' ')) CASE(*MIXED) +
                          PROMPT('Print stdout print text')
             PARM       KWD(PRTHOLD) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) SPCVAL((*NONE +
                          ' ')) CASE(*MIXED) PROMPT('Print stdout +
                          hold spool file')
             PARM       KWD(PRTOUTQ) TYPE(QUAL2) MIN(1) +
                          PROMPT('Print stdout to outq')
             PARM       KWD(PASEJOBNAM) TYPE(*CHAR) LEN(10) +
                          DFT(*DEFAULT) CASE(*MIXED) PROMPT('PASE +
                          fork thread job names')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(*SAME) +
                          SPCVAL((*SAME)) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL)) EXPR(*YES) PROMPT('Library')
