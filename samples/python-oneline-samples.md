# One line Python command samples
These samples can be easily run with the relevant QSHONI commands to run simple one line Python commands and bring the results back for use from within a RPG, CL or COBOL application program. Apparently PHP and other languages support the ability to run non-scripted programs also.   

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

## Python output any print() statement result
```
python3 -c 'print("RETURNPARM01:Hello World")'
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
## Python output last Friday's date
List of Python commands before one-liner
```
from datetime import date, timedelta
friday = 4
today = date.today()
delta = today.weekday() - friday
last_friday = today - timedelta((7 if delta < 0 else 0) + delta)
print(last_friday)
```
One liner
```
 python3 -c 'from datetime import date, timedelta; friday = 4; today = date.today(); delta = today.weekday() - friday; last_friday = today - timedelta((7 if delta < 0 else 0) + delta); print(last_friday)'
```
**Note** that the Python builtin `datetime` library defines no symbolic constants for weekdays. It offers only `datetime.date.weekday()` numbering the days 0-6 starting with Monday, and `datetime.date.isoweekday()` numbering the days 1-7 starting with Monday. Our one-liner defines `friday = 4` for clarity; the definition is not necessary.
