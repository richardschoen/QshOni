             CMD        PROMPT('Copy Source Member to Script')
             PARM       KWD(SRCFILE) TYPE(QUAL4) MIN(1) +
                          PROMPT('Source file')
             PARM       KWD(SRCMBR) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Source member')
             PARM       KWD(SRCTYPE) TYPE(*CHAR) LEN(10) +
                          DFT(*MEMBER) CASE(*MIXED) PROMPT('Source +
                          type for auto generate')
             PARM       KWD(TOIFSFILE) TYPE(*CHAR) LEN(255) +
                          DFT(*GENERATE) PROMPT('To IFS script file')
             PARM       KWD(IFSOPT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*REPLACE) VALUES(*ADD *REPLACE *NONE) +
                          PROMPT('IFS file option')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(*SAME) +
                          SPCVAL((*SAME)) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL)) EXPR(*YES) PROMPT('Library')
 QUAL3:      QUAL       TYPE(*NAME) LEN(10) DFT(STDOUTQSH) +
                          SPCVAL((*SAME)) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*LIBL)) EXPR(*YES) PROMPT('Library')
 QUAL4:      QUAL       TYPE(*NAME) SPCVAL((*SAME)) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL)) EXPR(*YES) PROMPT('Library')
