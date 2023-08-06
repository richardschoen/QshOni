# One line Python command samples
These samples can be easily run with the relevant QSHONI commands to run simple Python one line Python commands and bring them back for use from within a RPG, CL or COBOL application program. Apparently PHP and other languages support the ability to run non-scripted programs also.   

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
```
python3 -c 'import uuid; print("RETURNPARM01:"+str(uuid.uuid4()))'
```

## Actual Python single liner to return UUID value by itself for use in QSHEXEC and reading STDOUTQSH outfile
```
python3 -c 'import uuid; print(uuid.uuid4())'
```

## Python output current date (Ex: 2023-08-04)
```
python3 -c 'from datetime import date; print(date.today())'
```

## Python output current date and time including milliseconds (Ex: 2023-08-04 10:29:01.744188)
```
python3 -c 'import datetime; print(datetime.datetime.now())'
```

## Python output date 7 days back from todays date (Ex: Today: 2023-08-06  Date 7 days ago: 2023-07-30)
```
python3 -c 'import datetime as dt; print(dt.date.today()- dt.timedelta(days=7))'
```





