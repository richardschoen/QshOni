      *---------------------------------------------------------
      * Source information
      * @@LIBRARY: QSHONI
      * @@FILE: SOURCE
      * @@MEMBER: QSHSTDOUTR
      * @@TYPE: RPGLE
      * @@TEXT: Read and parse stdout log
      *---------------------------------------------------------
     H DFTACTGRP(*NO) ACTGRP(*NEW)

     FSTDOUTQSH IF   F 1000        DISK    USROPN
      /include QSYSINC/QRPGLESRC,QUSEC
      //  SEND Program Message API

     D QMHSNDPM        PR                  ExtPgm('QMHSNDPM')
     D  szMsgID                       7A   Const
     D  szMsgFile                    20A   Const
     D  szMsgData                  6000A   Const OPTIONS(*varsize)
     D  nMsgDataLen                  10I 0 Const

      **  Message Type may be one of the following:
      **  *COMP    - Completion
      **  *DIAG    - Diagnostic
      **  *ESCAPE  - Escape
      **  *INFO    - Informational
      **  *INQ     - Inquiry.
      **             (Only used when ToPgmQ(*EXT) is specified).
      **  *NOTIFY  - Notify
      **  *RQS     - Request
      **  *STATUS  - Status
     D  szMsgType                    10A   Const

      **  Call Stack Entry may be one of the following:
      **  *        - *SAME
      **  *EXT     - The external message queue
      **  *CTLBDY  - Control Boundary
      **  *PRV     - Program that called this procedure (*SAME)
      **  *PRVPGM  - Previous programo
     D  szCallStkEntry...
     D                               10A   Const
     D  nRelativeCallStkEntry...
     D                               10I 0 Const
     D  szRtnMsgKey                   4A
     D  apiErrorDS                         LikeDS(QUSEC)
     D                                     OPTIONS(*VARSIZE)

      // TODO: Include the QMHSNDPM API Prototype here

     D SndMsg          PR             4A
     D  szMsg                      1024A   Const Varying
     D  szMsgType                    10A   Const
     D                                     OPTIONS(*NOPASS)
     D  szToPgmQ                     10A   Const
     D                                     OPTIONS(*NOPASS)

     ISTDOUTQSH AA  01
     I                                  1  400  LOGDATA
     I                                  1   40  LOG40
     I                                 13  112  LOGRTN
     I                                  1    5  PARM5

     C*    *ENTRY        PLIST
     C*                  PARM                    RTNP1           100
     C*                  PARM                    RTNP2           100

      /free

      /IF DEFINED(*CRTBNDRPG)

       //  Read STDOUT log file now
       OPEN STDOUTQSH;

       // Stdout being message
       SndMsg('------------------------------':'*INFO':'*PRVPGM') ;
       SndMsg('Begin Stdout Qsh':'*INFO':'*PRVPGM') ;
       SndMsg('------------------------------':'*INFO':'*PRVPGM') ;

       // Loop thru java STDOUT results
       READ STDOUTQSH;
       DOW Not %EOF(STDOUTQSH);

         // Pick off the return parm values
         // and set the return fields.
        SndMsg(%TRIM(LogData):'*INFO':'*PRVPGM') ;

        //IF PARM5 = 'PARM1';
        //    RTNP1 = LOGRTN;
        //ELSEIF PARM5 = 'PARM2';
        //    RTNP2 = LOGRTN;
        //ENDIF;
         READ STDOUTQSH;

       ENDDO;

       SndMsg('------------------------------':'*INFO':'*PRVPGM') ;
       SndMsg('End Stdout QSH':'*INFO':'*PRVPGM') ;
       SndMsg('------------------------------':'*INFO':'*PRVPGM') ;

       CLOSE STDOUTQSH;

       // All done, let's bail out
       *inlr = *on;
       return;

      /end-free
      /ENDIF

     P SndMsg          B                   Export
      *******************************************
      **  Send an impromptu message to a pgmq
      *******************************************
     D SndMsg          PI             4A
     D  msg                        1024A   Const Varying
     D  szMsgType                    10A   Const
     D                                     OPTIONS(*NOPASS)
     D  szToPgmQ                     10A   Const
     D                                     OPTIONS(*NOPASS)

      *******************************************
      /include qsysinc/qrpglesrc,qusec
      *******************************************
      **  Local variables.
     D  msgType        S                   Like(szMsgType) Inz('*INFO')
     D  toPgmQ         S                   Like(szToPgmQ)  Inz('*')

     D msgid           S              7A   Inz('QSS9898')
     D msgf            DS            21
     D  MsgFile                      10A   Inz('QSHMSG')
     D  MsgLib                       10A   Inz('QSHONI')
     D
     D msgData         S           1024A
     D nDataLen        S             10I 0 Inz(0)
     D nRelInv         S             10I 0 Inz(1)
     D nIncInv         S             10I 0 Inz(1)
     D RtnMsgKey       S              4A
     D myAPIErrorDS    DS                  LikeDS(QUSEC)

     C                   eval      myApiErrorDS = *ALLX'00'

     C                   if        %Parms()>=2
     C                   eval      msgType = szMsgType
     C                   if        %subst(msgType:1:1)<>'*'
     C                   eval      msgType = '*' + %TrimL(msgType)
     C                   endif
     C                   endif

     C                   if        %Parms()>= 3
     C                   if        szToPgmQ <> *BLANKS
     C                   eval      toPgmQ=  szToPgmQ
     C                   endif
     C                   if        toPgmQ = '*SAME'
     C                   eval      toPgmQ = '*'
     C                   endif
     C                   endif

         // Status messages always go ToPgmQ(*EXT)
     C                   if        msgType = '*STATUS'
     C                   eval      toPgmQ = '*EXT'
     C                   endif

     C                   if        msgType = '*'
     C                   eval      msgType = '*INFO'
     C                   endif

        // Get the length of the message to be sent.
     C                   eval      msgData = %Trim(msg)
     C                   eval      nDataLen = %len(%Trim(msg))

     C                   Select
      **  *SAME
     C                   when      toPgmQ  = ' '
     C                             or toPgmQ = '*SAME'
     C                             or toPgmQ = '*'
     C                   eval      toPgmQ = '*'
     C                   eval      nRelInv = 0
     C                   eval      nIncInv = 1
      **  *PRV, *PRVPRC or *PRVPROC
     C                   when      toPgmQ = '*PRVPRC'
     C                             or toPgmQ = '*PRVPROC'
     C                             or toPgmQ = '*PRV'
     C                   eval      toPgmQ = '*'
     C                   eval      nRelInv = 1
     C                   eval      nIncInv = 1
      **  *PRVPGM
     C                   When      toPgmQ = '*PRVPGM'
     C                   eval      toPgmQ = '*CTLBDY'
     C                   eval      nRelInv = 0
     C                   eval      nIncInv = 1
      **  *CTLBDY
     C                   when      toPgmQ = '*CTLBDY'
     C                   eval      nIncInv = 2
      **  *EXT
     C                   when      toPgmQ = '*EXT'
     C                   eval      nRelInv = 0
     C                   endsl

      **  Since we're a relative invocation, and we are
      **  one-level deep, we need to bump up the relative
      **  invocation by the calculated increment.
     C                   eval      nRelInv = nRelInv + nIncInv

     C                   callp(e)  QMHSNDPM(msgid   : msgf :
     C                                      msgData : nDataLen :
     C                                      msgType   :
     C                                      toPgmQ    :
     C                                      nRelInv   :
     C                                      rtnMsgKey :
     C                                      myAPIErrorDS)

     C                   return    rtnMsgKey
     P SndMsg          E

