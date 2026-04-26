**free
       //-------------------------------------------------------------------------------------------
       // QSHWRTLOGR - Double up any single quotes.
       //-------------------------------------------------------------------------------------------

       // Program DS
       Dcl-Ds *N psds;
          PROGID *PROC;
       End-Ds;

       Dcl-S sqt   Char(1) inz('''');
       Dcl-S dbqt  Char(2) inz('''''');

       // Program *entry parameter list prototype
       Dcl-pi QSHWRTLOGR;
          p_sql    CHAR(330);
          p_sqlrtn CHAR(330);
          p_rtnerror CHAR(1);
       End-pi ;

       // Initialize parm arrays from passed in values
       p_rtnerror='0';

       // Monitor for errors
       Monitor;

        // Double up single quotes in message text
        // so SQL won't fail if single quotes in field value
        p_sqlrtn=%scanrpl(sqt:dbqt:p_sql);

        // Monitor for errors
       On-Error;
          p_rtnerror='2';
          *inlr=*on;
          return;
       Endmon;

       // Exit
       *inlr=*on;
       return;
