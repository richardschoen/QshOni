             CMD        PROMPT('Verify IFS Save File')
             PARM       KWD(FRMIFSSAVF) TYPE(*CHAR) LEN(255) MIN(1) +
                          CASE(*MIXED) PROMPT('From IFS save file')
             PARM       KWD(DSPSAVF) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) MIN(0) +
                          CASE(*MIXED) PROMPT('Display save file')
             PARM       KWD(PRTSAVF) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) MIN(0) +
                          CASE(*MIXED) PROMPT('Print save file +
                          contents')
             PARM       KWD(DLTTMPSAVF) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*NO) VALUES(*NO *YES) +
                          MIN(0) CASE(*MIXED) PROMPT('Delete temp +
                          save file after')
