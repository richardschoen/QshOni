/* Desc: Sample Command to Use QSHPYRUN Internally -RPGLE */
             CMD        PROMPT('Sample Command to Use PYRUN')
             PARM       KWD(MY10ARGS) TYPE(*CHAR) LEN(200) RSTD(*NO) +
                          MAX(10) EXPR(*YES) CASE(*MIXED) +
                          INLPMTLEN(32) PROMPT('My 10 command +
                          arguments')
