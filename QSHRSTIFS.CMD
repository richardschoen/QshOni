             CMD        PROMPT('Restore IFS Obj from IFS File')
             PARM       KWD(OBJECTS) TYPE(*CHAR) LEN(255) MIN(1) +
                          CASE(*MIXED) PROMPT('IFS objects to restore')
             PARM       KWD(FRMIFSFILE) TYPE(*CHAR) LEN(255) MIN(1) +
                          CASE(*MIXED) PROMPT('From IFS file')
             PARM       KWD(DLTTMPSAVF) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          CASE(*MIXED) PROMPT('Delete temporary +
                          save file')
             PARM       KWD(PROMPT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) CASE(*MIXED) +
                          PROMPT('Prompt the RST command')
