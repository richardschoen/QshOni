# Query IBM i Data using SQL via the QSHQRYTMP command
If you're an IBM i-AS/400 developer you no doubt remember the days of OPNQRYF, GSORT or writing temporary files with a custom RPG program to create a summary file or some other temporary work table.   

The QSHQRYTMP command which is part of the Qhell on i utilities is a high level wrapper over the RUNSQL command that allows any SQL select command to be run and automatically written to an output file for further processing.   

The QSHQRYTMP command can be called from CL, RPG, COBOL and even QShell/PASE commands if needed to query data to an output file. Or outfile as we used to call them in the early days.    

# How it Works
I think you'll appreciate the simplicity of this CL command utility for taking any SQL based query and creating an output file from the results. 

The CL command is called QSHQRYTMP and it's part of the QShell on i utilities  - QSHONI (https://github.com/richardschoen/QshOni) I created for interacting with QShell and PASE apps from RPG, COBOL and CL. As a helper command the command does not require QShell or PASE, but it seemed like QSHONI was a good place for the command to live.

Here's a sample of how easy it is to create a new file from an SQL query with QSHQRYTMP:

QSHONI/QSHQRYTMP SQL('select * from qiws.qcustcdt where LSTNAM  = ''Henning''') OUTFILE(QTEMP/SQLTMP0001) EMPTYERROR(*YES) PROMPT(*NO)                        

Temp file QTEMP/SQLTMP0001 was created from query. 0000000001 records.

Notice that you need the extra single quotes on character values because CL commands require you to double things up when passing single quote delimited values like a character based query string.

There are also 3 data areas that get automatically created in the jobs current QTEMP library. These data areas return the temporary table name and record count info in case your process needs to know these values.    
```
QTEMP/SQLQRYCNT - Query Result Record Count
QTEMP/SQLQRYFIL - Query Result File Name
QTEMP/SQLQRYLIB - Query Result Lib Name
```    
QSHQRYTMP consists of a single CL command and CL command processing program that takes advantage of the power of the RUNSQL CL command to do most of it's work. 

I hope you enjoy using this command for creating SQL result files on-the-fly.  I have found it very useful.
