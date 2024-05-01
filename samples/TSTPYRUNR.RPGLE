        // Desc: Build out QSHPYRUN command line in RPG
     H DFTACTGRP(*NO) ACTGRP(*NEW)

     D ArgDS           Ds                  Qualified
     D  ArgCount                      4b 0
     D  ArgVal                      200a   Dim(10)

     D CurArg          S              5i 0
     D ArgParm         S           8000a   INZ('')
     D Qt              S              1a   INZ('''')

     C     *ENTRY        PLIST
     C                   PARM                    Args           8002
     C                   PARM                    CLCmd          9999
     C                   PARM                    CLCmdLen         15 5

      /free

        // Move command list args to data structure
        ArgDS=Args;

        // Iterate and consolidate each
        // argument into single parm for CL list.
        CurArg=1;
        Dow CurArg <= ArgDS.ArgCount;
            ArgParm = %trim(ArgParm) + ' ' + qt +
                      %trim(ArgDS.ArgVal(CurArg)) + qt;
            CurArg+=1;
        EndDo;

        // Assemble QSHPYRUN CL command line
        // Add question mark to prompt it
        CLCmd = '? QSHONI/QSHPYRUN ' +
                'SCRIPTDIR(''/tmp/script.py'') ' +
                'SCRIPTFILE(myscript.py) ' +
                 'ARGS(' + %trim(ArgParm) + ')';

        // Calculate full command length for QCMDEXEC
        CLCmdLen=%len(%trim(CLCmd));

        // Exit
        *inlr=*on;
        return;

      /end-free
