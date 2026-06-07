             CMD        PROMPT('Restore Objects from IFS File')
             PARM       KWD(OBJECTS) TYPE(*CHAR) LEN(10) +
                          SPCVAL((*ALL *ALL)) MIN(1) CASE(*MONO) +
                          PROMPT('Objects to save')
             PARM       KWD(LIBRARY) TYPE(*CHAR) LEN(10) MIN(1) +
                          CASE(*MONO) PROMPT('Library to restore')
             PARM       KWD(RSTLIB) TYPE(*CHAR) LEN(10) DFT(*SAVLIB) +
                          CASE(*MONO) PROMPT('Restore to library')
             PARM       KWD(CLRLIB) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) CASE(*MIXED) +
                          PROMPT('Clear restore to lib if exists')
             PARM       KWD(FRMIFSFILE) TYPE(*CHAR) LEN(255) MIN(1) +
                          CASE(*MIXED) PROMPT('From IFS file')
             PARM       KWD(DLTTMPSAVF) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          CASE(*MIXED) PROMPT('Delete temporary +
                          save file')
             PARM       KWD(PROMPT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) CASE(*MIXED) +
                          PROMPT('Prompt the RSTOBJ command')
