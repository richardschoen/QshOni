     Hcopyright('')
     Hbnddir('QC2LE')
     Hindent('--')
     Haut(*EXCLUDE)
     Hoptimize(*NONE)
      * The following options reduce the size of the compilation's listing by
      * eliminating the printing of copied members, cross-references, and
      * external procedures and fields.  Feel free to change them to meet
      * your needs.
     Hoption(*NOSHOWCPY : *NOXREF : *NOEXT)
     H*****************************************************************
     D*****************************************************************
     D* IFS PROTOTYPES
     D*****************************************************************
     D*** check for IFS file existence
     Daccess           PR            10I 0 EXTPROC('access')
     D  filename                       *   VALUE
     D  accessmode                   10I 0 VALUE
     D*** open an IFS file
     Dopen             PR            10I 0 EXTPROC('open')
     D  filename                       *   VALUE
     D  openflags                    10I 0 VALUE
     D  mode                         10U 0 VALUE OPTIONS(*NOPASS)
     D  codepage                     10U 0 VALUE OPTIONS(*NOPASS)
     D*** read an IFS file
     Dread             PR            10I 0 EXTPROC('read')
     D  filehandle                   10I 0 VALUE
     D  datareceived                   *   VALUE
     D  nbytes                       10U 0 VALUE
     D*** write to an IFS file
     Dwrite            PR            10I 0 EXTPROC('write')
     D  filehandle                   10I 0 VALUE
     D  datatowrite                    *   VALUE
     D  nbytes                       10U 0 VALUE
     D*** close an IFS file
     Dclose            PR            10I 0 EXTPROC('close')
     D  filehandle                   10I 0 VALUE
     D*****************************************************************
     D* IFS CONSTANTS
     D*****************************************************************
     D*** File Existence Mode for access()
     D F_OK            S             10I 0 INZ(0)
     D*** File Access Modes for open()
     D O_RDONLY        S             10I 0 INZ(1)
     D O_WRONLY        S             10I 0 INZ(2)
     D O_RDWR          S             10I 0 INZ(4)
     D*** oflag Values for open()
     D O_CREAT         S             10I 0 INZ(8)
     D O_EXCL          S             10I 0 INZ(16)
     D O_TRUNC         S             10I 0 INZ(64)
     D*** File Status Flags for open() and fcntl()
     D O_NONBLOCK      S             10I 0 INZ(128)
     D O_APPEND        S             10I 0 INZ(256)
     D*** oflag Share Mode Values for open()
     D O_SHARE_NONE    S             10I 0 INZ(2000000)
     D O_SHARE_RDONLY  S             10I 0 INZ(0200000)
     D O_SHARE_RDWR    S             10I 0 INZ(1000000)
     D O_SHARE_WRONLY  S             10I 0 INZ(0400000)
     D*** file permissions
     D S_IRUSR         S             10I 0 INZ(256)
     D S_IWUSR         S             10I 0 INZ(128)
     D S_IXUSR         S             10I 0 INZ(64)
     D S_IRWXU         S             10I 0 INZ(448)
     D S_IRGRP         S             10I 0 INZ(32)
     D S_IWGRP         S             10I 0 INZ(16)
     D S_IXGRP         S             10I 0 INZ(8)
     D S_IRWXG         S             10I 0 INZ(56)
     D S_IROTH         S             10I 0 INZ(4)
     D S_IWOTH         S             10I 0 INZ(2)
     D S_IXOTH         S             10I 0 INZ(1)
     D S_IRWXO         S             10I 0 INZ(7)
     D*** misc
     D O_TEXTDATA      S             10I 0 INZ(16777216)
     D O_CODEPAGE      S             10I 0 INZ(8388608)
     D*****************************************************************
     D* DATA DEFINITIONS
     D*****************************************************************
     D*** Miscellaneous data declarations
     D FileName        S            255A
     D FileLen         S              9B 0
     D RtnError        S              5P 0
     D Originator      S            255A
     D OriginName      S             80A
     D OriginLen       S              9B 0
     D CPFNumber       S                   Like(CPFID)
     D Subject         S            256A
     D Message         S            512A
     D AttachName      S            256A
     D AsciiCodePage   S             10U 0 INZ(819)
     D***
     D Addressee       S                   Like(Address)
     D AddresseeName   S                   Like(Address)
     D TotalRecp       S              9B 0
     D***
     D FileDesc        S             10I 0
     D BytesWrt        S             10I 0
     D Data            S            410A
     D AttachDesc      S             10I 0
     D BytesRead       S             10I 0
     D DataRead        S            410A
     D CRLF            S              2A   Inz(X'0D25')
     D Null            S              1A   Inz(X'00')
     D FullName        S            512A
     D ReturnInt       S             10I 0
     D Pos             S              5U 0
     D SavePos         S                   Like(Pos)
     D*** Data structure of recipient info.
     D Recipient       DS
     D  OffSet                 1      4B 0
     D  AddrLen                5      8B 0
     D  Format                 9     16
     D  DistrType             17     20B 0
     D  Reserved              21     24B 0
     D  Address               25    280
     D*** MIME Header fields
     D MSender         S            256A
     D MDateTime       S            256A
     D MFrom           S            256A
     D MMimeVer        S            256A
     D MTo             S            256A
     D MSubject        S            256A
     D MBoundary       S            256A   Inz('--PART.BOUNDARY.1')
     D*** Array of file attachments
     D Attachment      DS
     D  NbrFiles               1      2B 0
     D  AttachFile                  256A   Dim(30)
     D*** API error info
     D APIError        DS
     D  APIBytes               1      4B 0
     D  CPFID                  9     15
     D*** Constants
     D DTo             C                   Const(0)
     D DCC             C                   Const(1)
     D DBCC            C                   Const(2)
     D MsgSize         C                   Const(%Len(Message))
     C*********************************************************************
     C*** Parameter List
     C     *Entry        PList
     C                   Parm                    FileName
     C                   Parm                    RtnError
     C*
     C*** Initialize error structure
     C                   Eval      APIBytes   = 11
     C*** Initialize values
     C                   Eval      FileLen = %Len(%Trimr(FileName))
     C                   Eval      %Subst(FileName:FileLen+1:2) = X'0000'
     C*** Attempt to See if file exists in the IFS
     C                   Exsr      CheckFile
     C*** Return to caller
     C     Exit          Tag
     C                   EVAL      *INLR = *ON
     C*****************************************************************
     C* Check for file existence
     C*****************************************************************
     CSR   CheckFile     Begsr
     C*** Open file
     C                   Eval      FullName = %TRIMR(FileName) + Null
     C                   If        access(%ADDR(FullName): F_OK) = 0
     C                   Eval      RtnError = 0
     C                   Else
     C                   Eval      RtnError = -1
     C                   Endif
     C*
     C                   Endsr
     C*****************************************************************
     C* SUBROUTINE - ExitProgram                                        *
     C* PURPOSE    - Exit from the program                              *
     C*******************************************************************
     CSR   ExitProgram   BEGSR
     C                   EVAL      *INLR = *ON
     C                   RETURN
     C                   ENDSR
