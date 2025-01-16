             CMD        PROMPT('Scan IFS File for Value')
             PARM       KWD(IFSFILE) TYPE(*CHAR) LEN(255) MIN(1) +
                          CASE(*MIXED) PROMPT('IFS file to scan')
             PARM       KWD(SCANFOR) TYPE(*CHAR) LEN(100) RSTD(*NO) +
                          MIN(1) MAX(20) EXPR(*YES) CASE(*MIXED) +
                          INLPMTLEN(32) PROMPT('Values to scan for +
                          first match')
             PARM       KWD(EXACTMATCH) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*NO) VALUES(*NO *YES) +
                          CASE(*MIXED) PROMPT('Exact match-*YES, +
                          Contains-*NO')
             PARM       KWD(ENDLINFMT) TYPE(*CHAR) LEN(6) RSTD(*YES) +
                          DFT(*ALL) VALUES(*ALL *CR *LF *CRLF *LFCR +
                          *FIXED) CASE(*MIXED) PROMPT('End of line +
                          characters')
             PARM       KWD(DLTTMPFILE) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          CASE(*MIXED) PROMPT('Delete temp file after')
