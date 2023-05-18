/* Text: Start PostgreSQL Server */
             CMD        PROMPT('Start PostgreSQL Server')
             PARM       KWD(USERID) TYPE(*CHAR) LEN(10) +
                          DFT(POSTGRES) SPCVAL((*CURRENT *CURRENT)) +
                          PROMPT('User ID to submit job as')
