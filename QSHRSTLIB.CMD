             CMD        PROMPT('Restore Library from IFS File')
             PARM       KWD(LIBRARY) TYPE(*CHAR) LEN(10) MIN(1) +
                          CASE(*MONO) PROMPT('Library to restore')
             PARM       KWD(RSTLIB) TYPE(*CHAR) LEN(10) DFT(*SAVLIB) +
                          CASE(*MONO) PROMPT('Restore to library')
             PARM       KWD(CLRLIB) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) CASE(*MIXED) +
                          PROMPT('Clear restore to lib if exists')
             PARM       KWD(FRMIFSFILE) TYPE(*CHAR) LEN(255) MIN(1) +
                          CASE(*MIXED) PROMPT('From IFS file')
             PARM       KWD(OPTION) TYPE(*CHAR) LEN(10) DFT(*ALL) +
                          SPCVAL((*ALL *ALL) (*NEW *NEW) (*OLD +
                          *OLD) (*FREE *FREE)) CASE(*MIXED) +
                          PROMPT('Option')
             PARM       KWD(MBROPT) TYPE(*CHAR) LEN(10) DFT(*ALL) +
                          SPCVAL((*ALL *ALL) (*NEW *NEW) (*OLD +
                          *OLD) (*MATCH *MATCH)) CASE(*MIXED) +
                          PROMPT('Database member option')
             PARM       KWD(ALWOBJDIF) TYPE(*CHAR) LEN(11) +
                          DFT(*ALL) SPCVAL((*ALL *ALL) (*COMPATIBLE +
                          *COMPATIBLE) (*NONE *NONE)) CASE(*MIXED) +
                          PROMPT('Allow object differences')
             PARM       KWD(DLTTMPSAVF) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          CASE(*MIXED) PROMPT('Delete temporary +
                          save file')
             PARM       KWD(PROMPT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) CASE(*MIXED) +
                          PROMPT('Prompt the RSTLIB command')
