             CMD        PROMPT('End Seiden Web Server')
             PARM       KWD(HTTPINST) TYPE(*CHAR) LEN(10) MIN(1) +
                          CASE(*MONO) PROMPT('HTTP instance name')
             PARM       KWD(JOBNAME) TYPE(*CHAR) LEN(10) +
                          DFT(*HTTPINST) PROMPT('Job name')
             PARM       KWD(DLYJOB) TYPE(*DEC) LEN(5) DFT(10) +
                          PROMPT('Delay job in seconds')
             PARM       KWD(WAITCYCLES) TYPE(*DEC) LEN(5) DFT(10) +
                          PROMPT('Number of delay cycles to wait')
             PARM       KWD(SNDOPRMSG) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*YES *NO) PROMPT('Send +
                          operator message')
             PARM       KWD(TOUSR) TYPE(*CHAR) LEN(10) DFT(*SYSOPR) +
                          PROMPT('To user') 
