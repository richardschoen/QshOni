             CMD        PROMPT('Copy Source Mbr to IFS File')
             PARM       KWD(SRCFILE) TYPE(QUAL4) MIN(1) +
                          PROMPT('Source file')
             PARM       KWD(SRCMBR) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Source member')
             PARM       KWD(IFSFILE) TYPE(*CHAR) LEN(255) +
                          DFT(*GENERATE) EXPR(*YES) CASE(*MIXED) +
                          PROMPT('Destination IFS file')
             PARM       KWD(REPLACE) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Replace +
                          existing IFS file')
 QUAL4:      QUAL       TYPE(*NAME) SPCVAL((*SAME)) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL)) EXPR(*YES) PROMPT('Library')
