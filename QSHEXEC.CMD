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
             PARM       KWD(PRTSPLF) TYPE(*CHAR) LEN(10) DFT(QSHEXECLOG) PROMPT('Print stdout spool +
                          file')
             PARM       KWD(PRTUSRDTA) TYPE(*CHAR) LEN(10) DFT(*NONE) SPCVAL((*NONE ' ')) +
                          PROMPT('Print stdout user data')
             PARM       KWD(PRTTXT) TYPE(*CHAR) LEN(30) DFT(*NONE) SPCVAL((*NONE ' ')) CASE(*MIXED) +
                          PROMPT('Print stdout print text')
