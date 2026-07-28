             CMD        PROMPT('SQL Query Data to Temp Table')
             PARM       KWD(SQL) TYPE(*CHAR) LEN(5000) MIN(1) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('SQL query')
             PARM       KWD(PARMS) TYPE(*CHAR) LEN(100) RSTD(*NO) +
                          MAX(30) EXPR(*YES) CASE(*MIXED) +
                          INLPMTLEN(32) PROMPT('SQL placeholder +
                          parm name')
             PARM       KWD(PARMVALS) TYPE(*CHAR) LEN(100) RSTD(*NO) +
                          MAX(30) EXPR(*YES) CASE(*MIXED) +
                          INLPMTLEN(32) PROMPT('SQL parm +
                          replacement value')
             PARM       KWD(OUTFILE) TYPE(QUAL2) MIN(0) MAX(1) +
                          PROMPT('Temp file to receive results')
             PARM       KWD(EMPTYERROR) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          MIN(0) MAX(1) PROMPT('Escape error if no +
                          result data')
             PARM       KWD(NAMING) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*SYS) VALUES(*SYS *SQL) MIN(0) MAX(1) +
                          PROMPT('Naming')
             PARM       KWD(PROMPT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) MIN(0) MAX(1) +
                          PROMPT('Prompt RUNSQL')
             PARM       KWD(CRTIDCOL) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) MIN(0) MAX(1) +
                          PROMPT('Create row identity column')
             PARM       KWD(IDCOLNAME) TYPE(*CHAR) DFT(RECID) MIN(0) +
                          MAX(1) CASE(*MIXED) PROMPT('Record ID +
                          column name')
             PARM       KWD(CPYRESULTS) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*NO) VALUES(*NO *YES) +
                          MIN(0) MAX(1) PROMPT('Copy results via CPYF')
             PARM       KWD(CPYTOFILE) TYPE(QUAL3) MIN(0) MAX(1) +
                          PROMPT('File to receive CPYF results')
             PARM       KWD(CRTFILE) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          MIN(0) MAX(1) PROMPT('Create results file')
             PARM       KWD(MBROPT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*ADD) VALUES(*NONE *ADD *REPLACE +
                          *UPDADD) MAX(1) PROMPT('Replace or add +
                          records')
             PARM       KWD(PROMPTCPYF) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*NO) VALUES(*NO *YES) +
                          MIN(0) MAX(1) PROMPT('Prompt the CPYF +
                          command')
             PARM       KWD(CLRAFTCPYF) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          MIN(0) MAX(1) PROMPT('Clear temp outfile +
                          after CPYF')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(SQLTMP0001) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')
 QUAL3:      QUAL       TYPE(*NAME) LEN(10) DFT(SQLCPY0001) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')
