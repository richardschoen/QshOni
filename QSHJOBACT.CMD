             CMD        PROMPT('Locate Selected Active Jobs')
             PARM       KWD(QRYFILTER) TYPE(*CHAR) LEN(500) +
                          DFT('JOBNAME LIKE ''MYJOB''') +
                          SPCVAL((*ALL 'JOBNAME LIKE ''%%''')) +
                          EXPR(*YES) CASE(*MIXED) PROMPT('Job info +
                          query filter')
             PARM       KWD(MAXJOBFND) TYPE(*DEC) LEN(10 0) +
                          DFT(*NOLIMIT) SPCVAL((*NOLIMIT 0)) +
                          PROMPT('Max number of jobs found')
             PARM       KWD(EXPJOBFND) TYPE(*DEC) LEN(10 0) +
                          DFT(*NOLIMIT) SPCVAL((*NOLIMIT 0)) +
                          PROMPT('Expected number of jobs found')
             PARM       KWD(OUTFILE) TYPE(QUAL2) MIN(0) MAX(1) +
                          PROMPT('File to receive results')
             PARM       KWD(EMPTYERROR) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          MIN(0) MAX(1) PROMPT('Escape error if no +
                          result data')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(JOBTMPA001) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library') 
