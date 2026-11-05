---------------------------------------------------------
-- Function: QSHBASH_TABLE
--
-- Desc: SQL Table function to run the QSHBASH command 
-- and return the temporary outfile QTEMP/STDOUTQSH results 
-- as a table result set.
--
-- Parameters:
-- P_COMMAND - Up to 2000 character QSH/Pase command line to run.
--
-- Fields in resulting table:
-- LINE_NO - Sequence line number in table
-- OUTPUT_LINE - The actil line contents from QTEMP/STDOUTQSH current line
-- CMD_SUCCESS - The success of running the QSHBASH command. 
--               0=Success, -1=Fail. Always make sure this is 0. 
--               Otherwise errors occurred on your PASE command so interrogate
--               OUTPUT_LINE for the cause.
---------------------------------------------------------
CREATE OR REPLACE FUNCTION QSHONI.QSHBASH_TABLE (
    P_COMMAND VARCHAR(2000)
)
RETURNS TABLE (
    LINE_NO INTEGER,
    OUTPUT_LINE VARCHAR(1000),
    CMD_SUCCESS INTEGER
)
LANGUAGE SQL
MODIFIES SQL DATA
EXTERNAL ACTION
NOT DETERMINISTIC
NOT FENCED
BEGIN

    DECLARE V_CL VARCHAR(5000);
    DECLARE V_LINE INTEGER DEFAULT 0;
    DECLARE V_CMDSUCCESS INTEGER DEFAULT 0;


    -- Construct QSHEXEC command
    SET V_CL =
        'QSHONI/QSHBASH CMDLINE(''' ||
        REPLACE(TRIM(P_COMMAND), '''', '''''') ||
        ''') DSPSTDOUT(*NO) LOGSTDOUT(*NO) PRTSTDOUT(*NO)';

    -- Execute command
    BEGIN
    
        -- Declare the handler at the top of the block
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN 
               -- Leave empty or do nothing to swallow the error
               SET V_CMDSUCCESS=-1; -- Error occurred on QSHEXEC command
        END;
    
        -- Call the CL command now 
        CALL QSYS2.QCMDEXC(V_CL);
    
    END;

    -- Return each stdout record
    FOR C1 AS
        --SELECT *
        SELECT CAST(STDOUTQSH AS VARCHAR(1000) CCSID 37) as LOGRECORD
        FROM QTEMP.STDOUTQSH
    DO

        SET V_LINE = V_LINE + 1;

        PIPE (
            V_LINE,
            RTRIM(C1.LOGRECORD),
            V_CMDSUCCESS
        );
        
    END FOR;

    RETURN;

END;

---------------------------------------------------------
-- Use QSHBASH_TABLE function to run a PASE command and 
-- return results as table
---------------------------------------------------------
SELECT *
FROM TABLE(
    QSHONI.QSHBASH_TABLE('ls -l /tmp')
) AS X;

-- Search for tmp in output_line from results
SELECT *
FROM TABLE(
    QSHONI.QSHBASH_TABLE('ls -l /tmp')
) AS X where output_line like '%tmp%';


