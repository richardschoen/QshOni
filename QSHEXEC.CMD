             CMD        PROMPT('Run Qshell Command Line')
             PARM       KWD(CMDLINE) TYPE(*CHAR) LEN(5000) MIN(1) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('QSH +
                          command line')
             PARM       KWD(SETPKGPATH) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('Set +
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
             PARM       KWD(PRTSPLF) TYPE(*CHAR) LEN(10) DFT(QSHEXECLOG) PROMPT('Print stdout spool +
                          file')
             PARM       KWD(PRTUSRDTA) TYPE(*CHAR) LEN(10) DFT(*NONE) SPCVAL((*NONE ' ')) +
                          PROMPT('Print stdout user data')
             PARM       KWD(PRTTXT) TYPE(*CHAR) LEN(30) DFT(*NONE) SPCVAL((*NONE ' ')) CASE(*MIXED) +
                          PROMPT('Print stdout print text')
             PARM       KWD(PRTHOLD) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) SPCVAL((*NONE +
                          ' ')) CASE(*MIXED) PROMPT('Print stdout +
                          hold spool file')
             PARM       KWD(PRTOUTQ) TYPE(QUAL2) MIN(1) +
                          PROMPT('Print stdout to outq')
             PARM       KWD(OUTFILE) TYPE(QUAL3) MIN(1) PROMPT('File +
                          to receive output')
             PARM       KWD(MBROPT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*REPLACE) VALUES(*ADD *REPLACE) +
                          PROMPT('Replace or add records')
             PARM       KWD(PASEJOBNAM) TYPE(*CHAR) LEN(10) +
                          DFT(*DEFAULT) CASE(*MIXED) PROMPT('PASE +
                          fork thread job names')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(*SAME) +
                          SPCVAL((*SAME)) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL)) EXPR(*YES) PROMPT('Library')
 QUAL3:      QUAL       TYPE(*NAME) LEN(10) DFT(STDOUTQSH) +
                          SPCVAL((*SAME)) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*LIBL)) EXPR(*YES) PROMPT('Library')
