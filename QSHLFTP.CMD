             CMD        PROMPT('Send/Rcv Files via Lftp/Sftp')
             PARM       KWD(SFTPHOST) TYPE(*CHAR) LEN(255) RSTD(*NO) +
                          MAX(1) CASE(*MIXED) PROMPT('SFTP server +
                          host/ip address')
             PARM       KWD(SFTPPORT) TYPE(*CHAR) LEN(5) RSTD(*NO) +
                          DFT(22) MAX(1) CASE(*MIXED) PROMPT('SFTP +
                          server port')
             PARM       KWD(SFTPUSER) TYPE(*CHAR) LEN(50) RSTD(*NO) +
                          MAX(1) CASE(*MIXED) PROMPT('SFTP user')
             PARM       KWD(SFTPPASS) TYPE(*CHAR) LEN(50) RSTD(*NO) +
                          DFT(*NONE) SPCVAL((*NONE ' ')) MAX(1) +
                          CASE(*MIXED) DSPINPUT(*NO) PROMPT('SFTP +
                          password')
             PARM       KWD(KEYFILE) TYPE(*CHAR) LEN(255) RSTD(*NO) +
                          DFT(*NOKEYFILE) SPCVAL((*NOKEYFILE ' ')) +
                          MAX(1) CASE(*MIXED) PROMPT('SSH private +
                          key file')
             PARM       KWD(KEYPASSWD) TYPE(*CHAR) LEN(100) +
                          RSTD(*NO) DFT(*NOPASSWORD) +
                          SPCVAL((*NOPASSWORD ' ')) MAX(1) +
                          CASE(*MIXED) DSPINPUT(*NO) PROMPT('SSH +
                          private key file password')
             PARM       KWD(LOCALFILE) TYPE(*CHAR) LEN(255) +
                          RSTD(*NO) MAX(1) CASE(*MIXED) +
                          PROMPT('Local file')
             PARM       KWD(REMOTEFILE) TYPE(*CHAR) LEN(255) +
                          RSTD(*NO) MAX(1) CASE(*MIXED) +
                          PROMPT('Remote File')
             PARM       KWD(OPTION) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*SEND) VALUES(*SEND *RECEIVE) +
                          MAX(1) CASE(*MONO) PROMPT('Transfer Option')
             PARM       KWD(REPLACE) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) MAX(1) +
                          CASE(*MONO) PROMPT('Replace destination +
                          file')
             PARM       KWD(SETPKGPATH) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          EXPR(*YES) CASE(*MONO) PROMPT('Set +
                          QOpenSys yum package path')
             PARM       KWD(DSPSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Display +
                          standard output result')
             PARM       KWD(LOGSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Log +
                          standard output to job log')
             PARM       KWD(PRTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Print +
                          standard output result')
             PARM       KWD(DLTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) PROMPT('Delete +
                          standard output result')
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
                          DFT(QSHLFTP) PROMPT('Print stdout spool +
                          file')
             PARM       KWD(PRTUSRDTA) TYPE(*CHAR) LEN(10) DFT(*NONE) SPCVAL((*NONE ' ')) +
                          PROMPT('Print stdout user data')
             PARM       KWD(PRTTXT) TYPE(*CHAR) LEN(30) DFT(*NONE) +
                          SPCVAL((*NONE ' ')) CASE(*MIXED) +
                          PROMPT('Print stdout print text')
             PARM       KWD(PRTHOLD) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) SPCVAL((*NONE +
                          ' ')) CASE(*MONO) PROMPT('Print stdout +
                          hold spool file')
             PARM       KWD(PRTOUTQ) TYPE(QUAL2) MIN(1) +
                          PROMPT('Print stdout to outq')
             PARM       KWD(PROMPTQSH) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) MAX(1) +
                          CASE(*MONO) PROMPT('Prompt for shell +
                          command line')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(*SAME) +
                          SPCVAL((*SAME)) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL)) EXPR(*YES) PROMPT('Library')

