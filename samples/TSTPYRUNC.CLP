             /* Desc: Sample Command to Use QSHPYRUN Internally */

             PGM        PARM(&ARGS)
             
             /* Sample command proessing program for */
             /* using embedded QSHPYRUN command.     */

             /* Variable for all potential passed args, */
             /* plus 2 characters for the parm count.   */
             DCL        VAR(&ARGS) TYPE(*CHAR) LEN(8002)
             DCL        VAR(&CT) TYPE(*DEC) STG(*AUTO) LEN(3 0)

             /* Parsed argument variables */
             DCL        VAR(&ARG01) TYPE(*CHAR) LEN(200)
             DCL        VAR(&ARG02) TYPE(*CHAR) LEN(200)
             DCL        VAR(&ARG03) TYPE(*CHAR) LEN(200)
             DCL        VAR(&ARG04) TYPE(*CHAR) LEN(200)
             DCL        VAR(&ARG05) TYPE(*CHAR) LEN(200)
             DCL        VAR(&ARG06) TYPE(*CHAR) LEN(200)
             DCL        VAR(&ARG07) TYPE(*CHAR) LEN(200)
             DCL        VAR(&ARG08) TYPE(*CHAR) LEN(200)
             DCL        VAR(&ARG09) TYPE(*CHAR) LEN(200)
             DCL        VAR(&ARG10) TYPE(*CHAR) LEN(200)

             /* Parse 10 optional arguments from CL command */
             CHGVAR     VAR(&CT) VALUE(%BINARY(&ARGS 1 2))
             IF         COND(&CT > 0) THEN(CHGVAR VAR(&ARG01) +
                          VALUE(%SST(&ARGS 3 200)))
             IF         COND(&CT > 1) THEN(CHGVAR VAR(&ARG02) +
                          VALUE(%SST(&ARGS 203 200)))
             IF         COND(&CT > 2) THEN(CHGVAR VAR(&ARG03) +
                          VALUE(%SST(&ARGS 403 200)))
             IF         COND(&CT > 3) THEN(CHGVAR VAR(&ARG04) +
                          VALUE(%SST(&ARGS 603 200)))
             IF         COND(&CT > 4) THEN(CHGVAR VAR(&ARG05) +
                          VALUE(%SST(&ARGS 803 200)))
             IF         COND(&CT > 5) THEN(CHGVAR VAR(&ARG06) +
                          VALUE(%SST(&ARGS 1003 200)))
             IF         COND(&CT > 6) THEN(CHGVAR VAR(&ARG07) +
                          VALUE(%SST(&ARGS 1203 200)))
             IF         COND(&CT > 7) THEN(CHGVAR VAR(&ARG08) +
                          VALUE(%SST(&ARGS 1403 200)))
             IF         COND(&CT > 8) THEN(CHGVAR VAR(&ARG09) +
                          VALUE(%SST(&ARGS 1603 200)))
             IF         COND(&CT > 9) THEN(CHGVAR VAR(&ARG10) +
                          VALUE(%SST(&ARGS 1803 200)))

             /* Call Python script now via QSHPYRUN */
             /* Pass all 10 arguments to QSHPYRUN   */
             /* whether we use them or not.         */
             /* They will get passed as extra blank */
             /* parameters to our Python script.    */
             /* Our Python script can ignore blank  */
             /* parameters.                         */
             /* Let's prompt so we can see the      */
             /* QSHPYRUN call. Remove ? for prod.   */
           ? QSHONI/QSHPYRUN SCRIPTDIR('/tmp/script.py') +
                          SCRIPTFILE(myscript.py) ARGS(&ARG01 +
                          &ARG02 &ARG03 &ARG04 &ARG05 &ARG06 &ARG07 +
                          &ARG08 &ARG09 &ARG10)

             MONMSG     MSGID(CPF0000) /* Exit nicely when command +
                          prompt ended */

             ENDPGM
