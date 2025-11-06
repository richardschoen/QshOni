             CMD        PROMPT('SQL Query Src to Temp Table')
             PARM       KWD(SRCFILE) TYPE(QUAL1) MIN(1) MAX(1) +
                          PROMPT('SQL source file' 2)
             PARM       KWD(SRCMBR) TYPE(*CHAR) LEN(10) MIN(1) +
                          EXPR(*YES) CASE(*MONO) PROMPT('Source +
                          member' 3)
             PARM       KWD(IFSFILE) TYPE(*CHAR) LEN(255) DFT(*NONE) +
                          SPCVAL((*NONE ' ')) MAX(1) PROMPT('SQL +
                          IFS source file' 4)
             PARM       KWD(PARMS) TYPE(*CHAR) LEN(100) RSTD(*NO) +
                          MAX(30) EXPR(*YES) CASE(*MIXED) +
                          INLPMTLEN(32) PROMPT('SQL placeholder +
                          parm name' 5)
             PARM       KWD(PARMVALS) TYPE(*CHAR) LEN(100) RSTD(*NO) +
                          MAX(30) EXPR(*YES) CASE(*MIXED) +
                          INLPMTLEN(32) PROMPT('SQL parm +
                          replacement value' 6)
             PARM       KWD(OUTFILE) TYPE(QUAL2) MIN(0) MAX(1) +
                          PROMPT('Temp file to receive results' 7)
             PARM       KWD(EMPTYERROR) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          MIN(0) MAX(1) PROMPT('Escape error if no +
                          result data' 8)
             PARM       KWD(NAMING) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*SYS) VALUES(*SYS *SQL) MIN(0) MAX(1) +
                          PROMPT('Naming' 9)
             PARM       KWD(PROMPT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) MIN(0) MAX(1) +
                          PROMPT('Prompt RUNSQL' 10)
             PARM       KWD(CRTIDCOL) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) MIN(0) MAX(1) +
                          PROMPT('Create row identity column' 11)
             PARM       KWD(IDCOLNAME) TYPE(*CHAR) DFT(RECID) MIN(0) +
                          MAX(1) CASE(*MIXED) PROMPT('Record ID +
                          column name' 12)
             PARM       KWD(DLTTMPSRC) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) MIN(0) MAX(1) +
                          PROMPT('Delete temp source file after' 13)
             PARM       KWD(SQLLOC) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*SRCMBR) VALUES(*SRCMBR *IFSFILE) +
                          MIN(0) MAX(1) PROMPT('SQL source from +
                          location type' 1)
             PARM       KWD(DLTCMTLINE) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          MIN(0) MAX(1) PROMPT('Del comment line +
                          from temp src' 14)
             PARM       KWD(DSPTMPSRC) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) MIN(0) MAX(1) +
                          PROMPT('Display temp source member' 15)
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(SQLTMP0001) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')
 QUAL1:      QUAL       TYPE(*NAME) LEN(10) MIN(1) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) SPCVAL((*LIBL +
                          *LIBL)) EXPR(*YES) PROMPT('Library')
