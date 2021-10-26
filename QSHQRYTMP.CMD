             CMD        PROMPT('SQL Query Data to Temp Table')
             PARM       KWD(SQL) TYPE(*CHAR) LEN(5000) MIN(1) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('SQL query')
             PARM       KWD(OUTFILE) TYPE(QUAL2) MIN(0) MAX(1) +
                          PROMPT('Temp file to receive results')
             PARM       KWD(EMPTYERROR) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          MIN(0) MAX(1) PROMPT('Escape error if no +
                          result data')
             PARM       KWD(PROMPT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) MIN(0) MAX(1) +
                          PROMPT('Prompt RUNSQL')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(SQLTMP0001) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')
