# QshOni
This IBM i library contains useful CL wrapper commands to allow Qshell and Pase apps to be called and consumed from regular IBM i jobs via CL, RPG or COBOL programs. It also has a CL command to scan stdout for a specific value if you need to do something simple to check for a successful command run.

The main benefit of this wrapper is to be able to integrate Qshell/Pase applications on-the-fly with standard IBM i job streams.

# Installing and Building QSHONI via Git clone
```
mkdir /qshoni
cd /qshoni 
git -c http.sslVerify=false clone --recurse-submodules https://github.com/richardschoen/QshOni.git
cd qshoni
build.sh  
```
After building the library the commands should be ready to use.

# Installing QSHONI library and creating QSHEXEC command objects

Download the **qshoni.savf** save file from the selected releases page. 

https://github.com/richardschoen/QshOni/releases  **(Latest version - V1.0.3)**

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
/QOpenSys/pkgs/bin/wget https://github.com/richardschoen/QshOni/releases/download/V1.0.3/qshoni.savf
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
      PRTSPLF(QSHEXECLOG) 
      PRTUSRDTA(*NONE)    
      PRTTXT(*NONE)       
```

The following example runs an SQL query with db2util and exports the results as JSON to the QTEMP/STDOUTQSH outfile:

```
      QSHEXEC CMDLINE('export DB2UTIL_JSON_CONTAINER=array;db2util -o json "select * from qiws.qcustcdt"')     
      DSPSTDOUT(*YES)                                      
```


# QSHEXEC command parms

**Overview** - This CL command can be used to run a QSH/PASE command and log the results appropriately.

**CMDLINE** - Qsh/Pase command line sequence to run. Semicolons can be used to run multiple commands.

**SETPKGPATH** - Add the IBM i Open Source Package path to PATH environment variable by calling QSHPATH command before running QSH/PASE commands. Default = *YES.

**DSPSTDOUT** - Display the outfile contents. Nice when debugging. 

**LOGSTDOUT** - Place STDOUT log entries into the current jobs job log. Use this if you want the log info in the IBM i joblog. All STDOUT entries are written as CPF message: **QSS9898**

**PRTSTDOUT** - Print STDOUT to a spool file. Use this if you want a spool file of the log output.

**DLTSTDOUT** - This option insures that the STDOUT IFS temp files get cleaned up after processing. All IFS log files get created in the /tmp/mono directory.

**PRTSPLF** - This option holds the name of the spool file used when PRTSTDOUT = *YES. It's a nice way to customize the stdout log prints. ***Default = QSHEXECLOG***

**PRTUSRDTA** - This option holds the name of the spool file user data used when PRTSTDOUT = *YES. ***Default = *NONE.***

**PRTTXT** - This option holds the name of the spool file print txt to be used when PRTSTDOUT = *YES. ***Default = *NONE.***


# Using the QSHBASH CL command to call a bash command sequence

The following example calls the ls command to list files for the /tmp directory using the bash command: 

 ```
      QSHBASH CMDLINE('cd /tmp;ls')   
      DSPSTDOUT(*YES)         
      LOGSTDOUT(*NO)          
      PRTSTDOUT(*NO)          
      DLTSTDOUT(*YES)
      PRTSPLF(QSHEXECLOG) 
      PRTUSRDTA(*NONE)    
      PRTTXT(*NONE)       
```

The following example runs an SQL query with db2util and exports the results as JSON to the QTEMP/STDOUTQSH outfile:

```
      QSHBASH CMDLINE('export DB2UTIL_JSON_CONTAINER=array;db2util -o json "select * from qiws.qcustcdt"')     
      DSPSTDOUT(*YES)                                      
```


# QSHBASH command parms

**Overview** - This CL command can be used to run a PASE bash command and log the results appropriately. 

The command is a convenience wrapper that can be used to call a bash command with QSHEXEC instead of having to type the following bash command sequence prefix on a QSHEXEC command line: ***bash -c cmdline***

**CMDLINE** - Bash command line sequence to run. Semicolons can be used to run multiple commands.

**SETPKGPATH** - Add the IBM i Open Source Package path to PATH environment variable by calling QSHPATH command before running QSH/PASE commands. Default = *YES.

**DSPSTDOUT** - Display the outfile contents. Nice when debugging. 

**LOGSTDOUT** - Place STDOUT log entries into the current jobs job log. Use this if you want the log info in the IBM i joblog. All STDOUT entries are written as CPF message: **QSS9898**

**PRTSTDOUT** - Print STDOUT to a spool file. Use this if you want a spool file of the log output.

**DLTSTDOUT** - This option insures that the STDOUT IFS temp files get cleaned up after processing. All IFS log files get created in the /tmp/mono directory.

**PRTSPLF** - This option holds the name of the spool file used when PRTSTDOUT = *YES. It's a nice way to customize the stdout log prints. ***Default = QSHBASHLOG***

**PRTUSRDTA** - This option holds the name of the spool file user data used when PRTSTDOUT = *YES. ***Default = *NONE.***

**PRTTXT** - This option holds the name of the spool file print txt to be used when PRTSTDOUT = *YES. ***Default = *NONE.***


# Using the QSHLOGSCAN CL command to scan the stdout outfile for the selected value after QSHEXEC has completed. 

The command returns a CPF9898 excape message if value not found. Otherwise a CPF9898 completion message. 

The following example scans the outfile log in file QTEMP/STDOUTQSH for a file named test.txt: 

 ```
      QSHLOGSCAN SCANFOR('test.txt')   
      EXACTMATCH(*YES)         
```      

# QSHLOGSCAN command parms

**Overview** - This CL command is a convenience command that can be used to scan a STDOUT log for a specific value to indicate success or failure.

**SCANFOR** - Text value to scan for on each line in the stdout outfile. The value passed IS case sensitive and must match the value in the log file.

**EXACTMATCH** - *YES - Value must match exactly and be the only thing on the selected line. *NO - At least one line must contain the value somewhere in the line. Good for generic matching.

# QSHPATH command parms

**Overview** - This CL command is a convenience command to add the IBM i Open Source packages directory name to the PATH environment variable.

**PKGPATH** - Specify IFS location to open source packages. ***DEFAULT = /QOpenSys/pkgs/bin**
