             CMD        PROMPT('SQL Add Unique ID Col to Table')
             PARM       KWD(OUTFILE) TYPE(QUAL2) MIN(0) MAX(1) +
                          PROMPT('Temp file to receive results')
             PARM       KWD(IDCOLNAME) TYPE(*CHAR) DFT(RECID) MIN(0) +
                          MAX(1) CASE(*MIXED) PROMPT('Record ID +
                          column name')
             PARM       KWD(PROMPT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) MIN(0) MAX(1) +
                          PROMPT('Prompt RUNSQL')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(SQLTMP0001) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')
