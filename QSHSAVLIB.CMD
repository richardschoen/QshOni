             CMD        PROMPT('Save Library to IFS File')
             PARM       KWD(LIBRARY) TYPE(*CHAR) LEN(10) MIN(1) +
                          CASE(*MONO) PROMPT('Library to save')
             PARM       KWD(TOIFSFILE) TYPE(*CHAR) LEN(255) +
                          SPCVAL((*DATETIME *DATETIME) (*DATE +
                          *DATE)) MIN(1) CASE(*MIXED) PROMPT('Save +
                          to IFS file')
             PARM       KWD(REPLACE) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) CASE(*MIXED) +
                          PROMPT('Replace output IFS file')
             PARM       KWD(TGTRLS) TYPE(*CHAR) LEN(10) RSTD(*NO) +
                          DFT(*CURRENT) SPCVAL((*PRV *PRV) (V7R1M0 +
                          V7R1M0) (V7R2M0 V7R2M0) (V7R3M0 V7R3M0) +
                          (V7R4M0 V7R4M0) (V7R5M0 V7R5M0)) +
                          CASE(*MIXED) PROMPT('Target release')
             PARM       KWD(UPDHST) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) CASE(*MIXED) +
                          PROMPT('Update history')
             PARM       KWD(PRECHK) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) CASE(*MIXED) +
                          PROMPT('Object pre-check')
             PARM       KWD(SAVACT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) CASE(*MIXED) +
                          PROMPT('Save active')
             PARM       KWD(SAVFDTA) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) CASE(*MIXED) +
                          PROMPT('Save file data')
             PARM       KWD(SPLFDTA) TYPE(*CHAR) LEN(5) RSTD(*YES) +
                          DFT(*NONE) VALUES(*NONE *ALL) +
                          CASE(*MIXED) PROMPT('Spooled file data')
             PARM       KWD(QDTA) TYPE(*CHAR) LEN(5) RSTD(*YES) +
                          DFT(*NONE) VALUES(*NONE *DTAQ) +
                          CASE(*MIXED) PROMPT('Queue data')
             PARM       KWD(DTACPR) TYPE(*CHAR) LEN(7) RSTD(*YES) +
                          DFT(*HIGH) VALUES(*NONE *DEV *NO *YES +
                          *LOW *MEDIUM *HIGH) CASE(*MIXED) +
                          PROMPT('Data compression')
             PARM       KWD(DLTTMPSAVF) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          CASE(*MIXED) PROMPT('Delete temporary +
                          save file')
             PARM       KWD(PROMPT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) CASE(*MIXED) +
                          PROMPT('Prompt the SAVLIB command')
