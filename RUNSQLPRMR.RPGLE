**free
       //-------------------------------------------------------------------------------------------
       // RUNSQLPRMR - Replace SQL template parameters with actual data
       // values and update the selected SQL statement passed in.
       //-------------------------------------------------------------------------------------------

       // Program DS
       Dcl-Ds *N psds;
          PROGID *PROC;
       End-Ds;

       // Parameter name list passed from CL
       Dcl-Ds parmnames;
         parmcount bindec(4);
         parms char(100) dim(30);
       End-Ds;
       // Parameter value list passed from CL
       Dcl-Ds parmvalues;
         parmvalcount bindec(4);
         parmvals char(100) dim(30);
       End-Ds;

       // Program *entry parameter list prototype
       Dcl-pi RUNSQLPRMR;
          p_sql    CHAR(5000);
          p_parms  CHAR(3002);
          p_parmvals CHAR(3002);
          p_rtnerror CHAR(1);
       End-pi ;

       DCL-S curelem packed(5:0);
       DCL-S vparm  varchar(100);
       DCL-S vparmval varchar(100);

       // Initialize parm arrays from passed in values
       p_rtnerror='0';
       parmnames=p_parms;
       parmvalues=p_parmvals;

       // Each parm name passed must also have a value.
       if (parmcount <> parmvalcount);
          p_rtnerror='1';
          *inlr=*on;
          return;
       endif;

       // If no parms passed, exit now. All good. Nothing to do
       if (parmcount=0 or parmvalcount=0);
          p_rtnerror='0';
          *inlr=*on;
          return;
       endif;

       // Monitor for errors
       Monitor;

                // Loop through all parms and update current
                // source line if needed.
                for curelem = 1 to parmcount;

                   // Extract scanfor parm and replacement value
                   vparm=%trim(parms(curelem));
                   vparmval=%trim(parmvals(curelem));

                   // This handles mixed case, upper and lower
                   // for the keywords
                   // Replace parm with value if found
                   p_sql=%scanrpl(vparm:vparmval:p_sql);
                   // Replace uppercase with value if found
                   p_sql=%scanrpl(%upper(vparm):vparmval:p_sql);
                   // Replace lowercase with value if found
                   p_sql=%scanrpl(%upper(vparm):vparmval:p_sql);

                endfor;

     // Monitor for errors
     On-Error;
          p_rtnerror='3';
          *inlr=*on;
          return;
     Endmon;

     // Exit
     *inlr=*on;
     return;
