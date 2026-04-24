             CMD        PROMPT('Print Simple Log File')
             PARM       KWD(LOGFILE) TYPE(QUAL2) PROMPT('To log file')
             PARM       KWD(IFSFILE) TYPE(*CHAR) LEN(255) DFT(*NONE) +
                          PROMPT('IFS PDF output file name')
             PARM       KWD(REPLACE) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Replace +
                          existing PDF if found')
             PARM       KWD(PRTSPLF) TYPE(*CHAR) LEN(10) DFT(PRTLOG) +
                          PROMPT('Print spool file')
             PARM       KWD(PRTUSRDTA) TYPE(*CHAR) LEN(10) DFT(*NONE) SPCVAL((*NONE ' ')) +
                          PROMPT('Print user data')
             PARM       KWD(PRTTXT) TYPE(*CHAR) LEN(30) DFT(*NONE) SPCVAL((*NONE ' ')) CASE(*MIXED) +
                          PROMPT('Print print text')
             PARM       KWD(PRTHOLD) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) SPCVAL((*NONE +
                          ' ')) CASE(*MIXED) PROMPT('Print +
                          hold spool file')
             PARM       KWD(PRTOUTQ) TYPE(QUAL3) MIN(1) +
                          PROMPT('Print to outq')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(LOGTMP0001) +
                          SPCVAL((LOGTMP0001)) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*LIBL)) EXPR(*YES) PROMPT('Library')
 QUAL3:      QUAL       TYPE(*NAME) LEN(10) DFT(*SAME) +
                          SPCVAL((*SAME)) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL)) EXPR(*YES) PROMPT('Library')
