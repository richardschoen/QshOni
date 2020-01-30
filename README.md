# QshOni
This IBM i library contains useful CL wrapper commands to allow Qshell and Pase apps to be called and consumed from regular IBM i jobs via CL, RPG or COBOL programs. It also has a CL command to scan stdout for a specific value if you need to do something simple to check for a successful command run.

The main benefit of this wrapper is to be able to integrate Qshell/Pase applications on-the-fly with standard IBM i job streams.

# Installing QSHONI library and creating QSHEXEC command objects

Download the **qshoni.savf** save file from the selected releases page. 

https://github.com/richardschoen/QshOni/releases

Upload the **qshoni.savf** to the IFS and place it in **/tmp/qshoni.savf**

Run the following commands to copy the save file from the IFS into a SAVF object

`CRTSAVF FILE(QGPL/QSHONI)`
 
`CPYFRMSTMF FROMSTMF('/tmp/qshoni.savf') TOMBR('/qsys.lib/qgpl.lib/qshoni.file') MBROPT(*REPLACE) CVTDTA(*NONE)`

Restore the QSHONI library

`RSTLIB SAVLIB(QSHONI) DEV(*SAVF) SAVF(QGPL/QSHONI)`

Build the QSHONI commands

`ADDLIBLE QSHONI`

`CRTCLPGM PGM(QSHONI/SRCBLDC) SRCFILE(QSHONI/SOURCE) SRCMBR(SRCBLDC) REPLACE(*YES)`

`CALL PGM(QSHONI/SRCBLDC)`

# Installing QSHONI library via wget and creating NODE command objects

Run the following commands to copy the save file from github into a SAVF object

`CRTSAVF FILE(QGPL/QSHONI)`

From QSHELL/QPTERM or BASH run:

```
/QOpenSys/pkgs/bin/wget https://github.com/richardschoen/QshOni/releases/download/V1.01/qshoni.savf
--no-check-certificate -O  /qsys.lib/qgpl.lib/qshoni.file
```

Restore the QSHONI library

`RSTLIB SAVLIB(QSHONI) DEV(*SAVF) SAVF(QGPL/QSHONI)`

Build the QSHONI commands

`ADDLIBLE QSHONI`

`CRTCLPGM PGM(QSHONI/SRCBLDC) SRCFILE(QSHONI/SOURCE) SRCMBR(SRCBLDC) REPLACE(*YES)`

`CALL PGM(QSHONI/SRCBLDC)`



# Using the QSHEXEC CL command to call a Qsh/Pase command sequence

The following example calls the ls command to list files for the /tmp directory: 

 ```
      QSHEXEC CMDLINE('cd /tmp;ls')   
      DSPSTDOUT(*YES)         
      LOGSTDOUT(*NO)          
      PRTSTDOUT(*NO)          
      DLTSTDOUT(*YES)         
```

The following example runs an SQL query with db2util and exports the results as JSON to the QTEMP/STDOUTQSH outfile:

```
      QSHEXEC CMDLINE('export DB2UTIL_JSON_CONTAINER=array;db2util -o json "select * from qiws.qcustcdt"')     
      DSPSTDOUT(*YES)                                      
```


# QSHEXEC command parms

**CMDLINE** - Qsh/Pase command line sequence to run. Semicolons can be used to run multiple commands.

**DSPSTDOUT** - Display the outfile contents. Nice when debugging. 

**LOGSTDOUT** - Place STDOUT log entries into the current jobs job log. Use this if you want the log info in the IBM i joblog. All STDOUT entries are written as CPF message: **QSS9898**

**PRTSTDOUT** - Print STDOUT to a spool file. Use this if you want a spool file of the log output.

**DLTSTDOUT** - This option insures that the STDOUT IFS temp files get cleaned up after processing. All IFS log files get created in the /tmp/mono directory.



# Using the QSHLOGSCAN CL command to scan the stdout outfile for the selected value after QSHEXEC has completed. 

The command returns a CPF9898 excape message if value not found. Otherwise a CPF9898 completion message. 

The following example scans the outfile log in file QTEMP/STDOUTQSH for a file named test.txt: 

 ```
      QSHLOGSCAN SCANFOR('test.txt')   
      EXACTMATCH(*YES)         
```      

# QSHLOGSCAN command parms

**SCANFOR** - Text value to scan for on each line in the stdout outfile. The value passed IS case sensitive and must match the value in the log file.

**EXACTMATCH** - *YES - Value must match exactly and be the only thing on the selected line. *NO - At least one line must contain the value somewhere in the line. Good for generic matching.
