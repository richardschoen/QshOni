             CMD        PROMPT('List Selected Jobs to Outfile')
             PARM       KWD(QRYFILTER) TYPE(*CHAR) LEN(500) +
                          DFT('JOBNAME LIKE ''%%''') SPCVAL((*ALL +
                          'JOBNAME LIKE ''%%''')) EXPR(*YES) +
                          CASE(*MIXED) PROMPT('Job info query filter')
             PARM       KWD(OUTFILE) TYPE(QUAL2) MIN(0) MAX(1) +
                          PROMPT('File to receive results')
             PARM       KWD(PROMPT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) MIN(0) MAX(1) +
                          PROMPT('Prompt SQL for debug')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(JOBTMP0001) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library') 
