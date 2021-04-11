             CMD        PROMPT('Run Python Script via Qshell')
             PARM       KWD(SCRIPTDIR) TYPE(*CHAR) LEN(255) MIN(1) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('Python +
                          script directory')
             PARM       KWD(SCRIPTFILE) TYPE(*CHAR) LEN(255) MIN(1) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('Python +
                          script file name')
             PARM       KWD(ARGS) TYPE(*CHAR) LEN(200) RSTD(*NO) +
                          MAX(40) EXPR(*YES) CASE(*MIXED) +
                          INLPMTLEN(32) PROMPT('Python command line +
                          arguments')
             PARM       KWD(PYVERSION) TYPE(*CHAR) LEN(5) RSTD(*YES) +
                          DFT(3) VALUES(2 3) CASE(*MIXED) +
                          PROMPT('Python version')
             PARM       KWD(PYPATH) TYPE(*CHAR) LEN(255) +
                          DFT(*DEFAULT) +
                          SPCVAL(('/QOpenSys/pkgs/bin' +
                          '/QOpenSys/pkgs/bin') (*DEFAULT +
                          *DEFAULT)) EXPR(*YES) CASE(*MIXED) +
                          PROMPT('Python bin path')
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
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Prt +
                          standard output on errors')
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
             PARM       KWD(CCSID) TYPE(*CHAR) LEN(10) DFT(37) +
                          SPCVAL((*SAME *SAME)) PROMPT('Coded +
                          character set ID for job')
             PARM       KWD(PRTSPLF) TYPE(*CHAR) LEN(10) +
                          DFT(QSHPYRUN) PROMPT('Print stdout spool +
                          file')
             PARM       KWD(PRTUSRDTA) TYPE(*CHAR) LEN(10) +
                          DFT(*NONE) SPCVAL((*NONE ' ')) +
                          PROMPT('Print stdout user data')
             PARM       KWD(PRTTXT) TYPE(*CHAR) LEN(30) DFT(*NONE) +
                          SPCVAL((*NONE ' ')) CASE(*MIXED) +
                          PROMPT('Print stdout print text')
