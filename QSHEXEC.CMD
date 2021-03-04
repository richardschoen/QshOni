/*------------------------------------------------------------*/
/* @@LIBRARY: QSHONI                                          */
/* @@FILE: SOURCE                                             */
/* @@MEMBER: QSHEXEC                                          */
/* @@TYPE: CMD                                                */
/* @@TEXT: Run QShell Command Line                            */
/*------------------------------------------------------------*/
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
             PARM       KWD(PRTSPLF) TYPE(*CHAR) LEN(10) DFT(QSHEXECLOG) PROMPT('Print stdout spool +
                          file')
             PARM       KWD(PRTUSRDTA) TYPE(*CHAR) LEN(10) DFT(*NONE) SPCVAL((*NONE ' ')) +
                          PROMPT('Print stdout user data')
             PARM       KWD(PRTTXT) TYPE(*CHAR) LEN(30) DFT(*NONE) SPCVAL((*NONE ' ')) CASE(*MIXED) +
                          PROMPT('Print stdout print text')
 
