/* Text: Backup Postgres Database via pg_dump to tar format */
             CMD        PROMPT('Backup Postgres DB via pg_dump')
             PARM       KWD(DATABASE) TYPE(*CHAR) LEN(255) MIN(1) +
                          CASE(*MIXED) PROMPT('Postgres database name')
             PARM       KWD(OUTPUTFILE) TYPE(*CHAR) LEN(255) MIN(1) +
                          CASE(*MIXED) PROMPT('To IFS output file')
             PARM       KWD(FORMAT) TYPE(*CHAR) LEN(10) DFT('t') +
                          CASE(*MIXED) PROMPT('Database dump output +
                          format')
             PARM       KWD(REPLACE) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) CASE(*MIXED) +
                          PROMPT('Replace output file')
