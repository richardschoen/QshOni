             CMD        PROMPT('Print Simple Log File')
             PARM       KWD(LOGFILE) TYPE(QUAL2) PROMPT('To log file')
             PARM       KWD(SPLF) TYPE(*CHAR) LEN(10) DFT(PRTLOG) +
                          PROMPT('Log spool file name')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(LOGTMP0001) +
                          SPCVAL((LOGTMP0001)) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*LIBL)) EXPR(*YES) PROMPT('Library')
