# One line Python command samples
These samples can be easily run with the relevant QSHONI commands to run simple Python one line commands and bring them back for use from within a RPG, CL or COBOL application program.

## Generate and return UUID via QSHEXEC or QSHCALL

This example uses QSHEXEC. The UUID result can be read from STDOUT log file QTEMP/STDOUTQSH.    
```
QSHEXEC CMDLINE('python3 -c ''import uuid; print(uuid.uuid4())''')
```                    

This example uses QSHCALL. The UUID result will return in parameter &RTNPARM01.
```
QSHCALL CMDLINE('python3 -c ''import uuid; print("RETURNPARM01:"+str(uuid.uuid4()))''')                                       
        DSPSTDOUT(*YES)           
        RETURN01(&RTNPARM01)      
        RETURN02(&RTNPARM02)      
        RETURN03(&RTNPARM03)      
        RETURN04(&RTNPARM04)      
        RETURN05(&RTNPARM05)      
        RETURN06(&RTNPARM06)      
        RETURN07(&RTNPARM07)      
        RETURN08(&RTNPARM08)      
        RETURN09(&RTNPARM09)      
        RETURN10(&RTNPARM10)      
```

## Actual Python single liner to return UUID with RTNPARM01: prefix for QSHCALL return parm
```python3 -c 'import uuid; print("RETURNPARM01:"+str(uuid.uuid4()))'```

## Actual Python single liner to return UUID value by itself for use in QSHEXEC and reading STDOUTQSH outfile
```python3 -c 'import uuid; print(uuid.uuid4())'```
