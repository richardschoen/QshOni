             CMD        PROMPT('Scan Qshell Log for Value')
             PARM       KWD(SCANFOR) TYPE(*CHAR) LEN(1024) MIN(1) +
                          CASE(*MIXED) PROMPT('Value to scan for')
             PARM       KWD(EXACTMATCH) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*NO) VALUES(*NO *YES) +
                          CASE(*MIXED) PROMPT('Exact match-*YES, +
                          Contains-*NO')
