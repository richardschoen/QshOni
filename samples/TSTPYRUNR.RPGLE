     H DFTACTGRP(*NO) ACTGRP(*NEW)

     C     *ENTRY        PLIST
     C                   PARM                    ARGS           8002
     C                   PARM                    CLCMD          9999
     C                   PARM                    CLCMDLEN         15 5

      /free

        // Assemble CL command line
        // Add question mark to prompt it
        CLCMD = '? QSHONI/QSHPYRUN ' +
                'SCRIPTDIR(''/tmp/script.py'') ' +
                'SCRIPTFILE(myscript.py) ' +
                 'ARGS(' +
                 ')';

        // Calculate full command length for QCMDEXEC
        clcmdlen=%len(%trim(CLCMD));


        *inlr=*on;
        return;
      /end-free
