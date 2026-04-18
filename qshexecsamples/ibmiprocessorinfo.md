## List IBM i CPU and Processor Info
You can also do the CALL from a 5250 command line of QSH/PASE shell, but this works nicely to capture the info for programatic usage if needed.
```
QSHONI/QSHEXEC CMDLINE('system "CALL QSYS/QLZARCAPI"')  
               DSPSTDOUT(*YES)                          
```
