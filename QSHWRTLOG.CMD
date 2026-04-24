             CMD        PROMPT('Write Simple Log Message')
             PARM       KWD(MSG) TYPE(*CHAR) LEN(330) MIN(1) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('Message')
             PARM       KWD(MSGTYPE) TYPE(*CHAR) LEN(10) DFT(INFO) +
                          SPCVAL((INFO INFO) (WARNING WARNING) +
                          (ERROR ERROR) (DIAG DIAG) (COMP COMP)) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('Message +
                          type')
             PARM       KWD(LOGFILE) TYPE(QUAL2) PROMPT('To log file')
             PARM       KWD(RECREATE) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Dlt and +
                          create log file before')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(LOGTMP0001) +
                          SPCVAL((LOGTMP0001)) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*LIBL)) EXPR(*YES) PROMPT('Library')
