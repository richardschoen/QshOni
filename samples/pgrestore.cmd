/* Text: Restore Postgres Database via pg_restore */
/* Command processing program is: PGRESTOREC */
             CMD        PROMPT('Restore Postgres DB-pg_restore')
             PARM       KWD(DATABASE) TYPE(*CHAR) LEN(255) MIN(1) +
                          CASE(*MIXED) PROMPT('Postgres database name')
             PARM       KWD(INPUTFILE) TYPE(*CHAR) LEN(255) MIN(1) +
                          CASE(*MIXED) PROMPT('From IFS tar input +
                          file')
             PARM       KWD(OPTIONS) TYPE(*CHAR) LEN(100) DFT(' ') +
                          SPCVAL((*CLEARBEFORE '-c')) CASE(*MIXED) +
                          PROMPT('Options')
             PARM       KWD(PROMPT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) +
                          PROMPT('Prompt for QSH command')
