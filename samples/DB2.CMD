/* Text: Execute db2 Query to IFS Output File via bash */
             CMD        PROMPT('Execute Qsh db2 Query to IFS')
             PARM       KWD(SQL) TYPE(*CHAR) LEN(1024) MIN(1) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('SQL to +
                          execute')
             PARM       KWD(GENOPT) TYPE(*CHAR) LEN(200) MIN(1) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('General +
                          options')
             PARM       KWD(OUTPUTFILE) TYPE(*CHAR) LEN(255) +
                          RSTD(*NO) MAX(1) CASE(*MIXED) +
                          PROMPT('Output IFS file')
             PARM       KWD(OPTION) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*REPLACE) VALUES(*ADD *REPLACE) +
                          PROMPT('IFS file option')
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
             PARM       KWD(PRTSPLF) TYPE(*CHAR) LEN(10) DFT(DB2UTIL) PROMPT('Print stdout spool +
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
             PARM       KWD(PASEJOBNAM) TYPE(*CHAR) LEN(10) +
                          DFT(*DEFAULT) CASE(*MIXED) PROMPT('PASE +
                          fork thread job names')
             PARM       KWD(VIEWOUTPUT) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*NO) VALUES(*NO *YES) +
                          MAX(1) CASE(*MIXED) PROMPT('View output +
                          file')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(*SAME) +
                          SPCVAL((*SAME)) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL)) EXPR(*YES) PROMPT('Library')
