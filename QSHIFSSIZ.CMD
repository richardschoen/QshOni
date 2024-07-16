             CMD        PROMPT('Retrieve IFS File Size')
             PARM       KWD(FILE) TYPE(*PNAME) LEN(256) PROMPT('IFS +
                          file name' 1)
             PARM       KWD(SIZE) TYPE(*DEC) LEN(10) RTNVAL(*YES) +
                          PROMPT('Return file size        (10 0)' 2)
             PARM       KWD(ALLOCSIZE) TYPE(*DEC) LEN(10) +
                          RTNVAL(*YES) PROMPT('Return allocated +
                          size   (10 0)' 3)
             PARM       KWD(ESCONERROR) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          MIN(0) MAX(1) PROMPT('Escape error on not +
                          found')
