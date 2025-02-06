             CMD        PROMPT('Run SQL Action from Qry Source')
             PARM       KWD(SRCFILE) TYPE(QUAL1) MIN(1) MAX(1) +
                          PROMPT('SQL source file')
             PARM       KWD(SRCMBR) TYPE(*CHAR) LEN(10) MIN(1) +
                          EXPR(*YES) CASE(*MONO) PROMPT('Source +
                          member')
             PARM       KWD(PARMS) TYPE(*CHAR) LEN(100) RSTD(*NO) +
                          MAX(30) EXPR(*YES) CASE(*MIXED) +
                          INLPMTLEN(32) PROMPT('SQL placeholder +
                          parm name')
             PARM       KWD(PARMVALS) TYPE(*CHAR) LEN(100) RSTD(*NO) +
                          MAX(30) EXPR(*YES) CASE(*MIXED) +
                          INLPMTLEN(32) PROMPT('SQL parm +
                          replacement value')
             PARM       KWD(PROMPT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) MIN(0) MAX(1) +
                          PROMPT('Prompt RUNSQL')
             PARM       KWD(DLTTMPSRC) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) MIN(0) MAX(1) +
                          PROMPT('Delete temp source file after')
             PARM       KWD(COMMIT) TYPE(*CHAR) LEN(5) RSTD(*YES) +
                          DFT(*NONE) VALUES(*CHG *UR *CS *ALL *RS +
                          *NONE *NC *RR) MIN(0) MAX(1) +
                          PROMPT('Committment control')
             PARM       KWD(NAMING) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*SYS) VALUES(*SYS *SQL) MIN(0) MAX(1) +
                          PROMPT('Naming')
             PARM       KWD(OPTION) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*LIST) VALUES(*LIST *NOSRC *ERRLIST +
                          *NOLIST) MIN(0) MAX(1) PROMPT('Source +
                          listing options')
             PARM       KWD(OUTPUT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*NONE) VALUES(*ERROR *NOLIST *MSG +
                          *PRINT *NONE) MIN(0) MAX(1) +
                          PROMPT('Listing output')
             PARM       KWD(SECLVLTXT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*YES *NO) MIN(0) MAX(1) +
                          PROMPT('Second level text')
             PARM       KWD(DSPOUTPUT) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*NO) VALUES(*NO *YES) +
                          MIN(0) MAX(1) PROMPT('Display output +
                          output report')
             PARM       KWD(PRTTMPSRC) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) MIN(0) MAX(1) +
                          PROMPT('Print temp source member')
             PARM       KWD(SPLF) TYPE(*CHAR) LEN(10) +
                          DFT(RUNSQLSRCP) MIN(0) MAX(1) +
                          PROMPT('Print source spool file name')
             PARM       KWD(USRDTA) TYPE(*CHAR) LEN(10) +
                          DFT(RUNSQLSRC) MIN(0) MAX(1) +
                          PROMPT('Print source user data')
             PARM       KWD(USRDFNDTA) TYPE(*CHAR) LEN(255) +
                          DFT(RUNSQLSRC) MIN(0) MAX(1) CASE(*MIXED) +
                          PROMPT('Print user defined data')
             PARM       KWD(PRTOUTQ) TYPE(QUAL3) MIN(1) +
                          PROMPT('Print to outq')
 QUAL3:      QUAL       TYPE(*NAME) LEN(10) DFT(*SAME) +
                          SPCVAL((*SAME)) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL)) EXPR(*YES) PROMPT('Library')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(SQLTMP0001) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')
 QUAL1:      QUAL       TYPE(*NAME) LEN(10) MIN(1) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) SPCVAL((*LIBL +
                          *LIBL)) EXPR(*YES) PROMPT('Library')
