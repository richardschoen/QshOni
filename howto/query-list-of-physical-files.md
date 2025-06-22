# Query IBM i and Get a List of Physical Files using QSYS2.SYSTABLES
This command will allow you to list physycal files and SQL tables for data files and/or source files using the QSHQRYTMP command. Once the outfile is created you can process it however you like in RPG or CL. 

```
QSHONI/QSHQRYTMP SQL('SELECT * FROM QSYS2.SYSTABLES WHERE TABLE_TYPE IN (''P'', ''T'') AND TABLE_SCHEMA = ''@@LIBRARY'' AND FILE_TYPE = ''D''') OUTFILE(QTEMP/SQLTMP0001) EMPTYERROR(*YES) PROMPT(*NO)                       ```
