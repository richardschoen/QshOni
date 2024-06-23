/* Member name: PGDUMP  */
/* Source type: CMD */
/* Text: Backup Postgres Database via pg_dump to tar format */
/* Command processing program is: PGDUMPC */
             CMD        PROMPT('Backup Postgres DB via pg_dump')
             PARM       KWD(DATABASE) TYPE(*CHAR) LEN(255) MIN(1) +
                          CASE(*MIXED) PROMPT('Postgres database name')
             PARM       KWD(OUTPUTFILE) TYPE(*CHAR) LEN(255) MIN(1) +
                          CASE(*MIXED) PROMPT('To IFS output file')
             PARM       KWD(FORMAT) TYPE(*CHAR) LEN(10) DFT('t') +
                          CASE(*MIXED) PROMPT('Database dump output +
                          format')
             PARM       KWD(OPTIONS) TYPE(*CHAR) LEN(100) DFT('-p +
                          5432 -U postgres') CASE(*MIXED) +
                          PROMPT('Options')
             PARM       KWD(PROMPT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) CASE(*MIXED) +
                          PROMPT('Prompt for QSHBASH')
             PARM       KWD(REPLACE) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) CASE(*MIXED) +
                          PROMPT('Replace output file')
