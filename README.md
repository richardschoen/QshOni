# QshOni
This IBM i library contains useful CL wrapper commands to allow Qshell and Pase apps to be called and consumed from regular IBM i jobs via CL, RPG or COBOL programs. It also has a CL command to scan stdout for a specific value if you need to do something simple to check for a successful command run.

The main benefit of this wrapper is to be able to integrate Qshell/Pase applications on-the-fly with standard IBM i job streams.

There are several ways to build the library. Pick your favorite.

# Check latest version info (Current Version 1.0.25 - 8/4/2023)  
https://github.com/richardschoen/QshOni/blob/master/VERSION.TXT   

```Two new commands added: QSHCALL and QSYPYCALL to call Python or other open source and return parameters.```

# Check out one-liner Python samples
https://github.com/richardschoen/QshOni/blob/master/samples/python-oneline-samples.md
   
# Installing and Building QSHONI via getrepo-qshoni.sh script 

***(Important to change SRCCCSID variable in build.sh to your local CCSID before running build.sh. Default=37)***

Use this install script if you want to run a single shell script to clone the repo and build the library.  
https://github.com/richardschoen/QshOni/blob/master/getrepo-qshoni.sh

```
# Download the getrepo-qshoni.sh script or create it manually in your IFS. 
# Then run the getrepo-qshoni.sh script to automatically clone the repo 
# and auto-run the build.sh to create the QSHONI library and associated 
# objects.

bash getrepo-qshoni.sh
```

# Installing and Building QSHONI via Git clone and build.sh 

***(Important to change SRCCCSID variable in build.sh to your local CCSID before running build.sh. Default=37)***

```
# Use this install method if you want to manually run each command from a QSH/PASE/SSH shell.
mkdir /qshoni
cd /qshoni 
git -c http.sslVerify=false clone --recurse-submodules https://github.com/richardschoen/QshOni.git
cd qshoni
build.sh  
```
After building the QSHONI library the commands should be ready to use.

# Installing QSHONI library via save file and creating QSHEXEC command objects

Use this install method if you want to install from a save file object.

Download the **qshoni.savf** save file from the selected releases page. 

https://github.com/richardschoen/QshOni/releases  **(Latest pre-built save file version - V1.0.14. Build from source for more current)**

Upload the **qshoni.savf** to the IFS and place it in **/tmp/qshoni.savf**

Run the following commands to copy the save file from the IFS into a SAVF object

`CRTSAVF FILE(QGPL/QSHONI)`
 
`CPYFRMSTMF FROMSTMF('/tmp/qshoni.savf') TOMBR('/qsys.lib/qgpl.lib/qshoni.file') MBROPT(*REPLACE) CVTDTA(*NONE)`

Restore the QSHONI library

`RSTLIB SAVLIB(QSHONI) DEV(*SAVF) SAVF(QGPL/QSHONI)`

Build the QSHONI commands

 ***(Important co CHGJOB CCSID(37) before building from SAVF)***

`CHGJOB CCSID(37)`

`ADDLIBLE QSHONI`

`CRTCLPGM PGM(QSHONI/SRCBLDC) SRCFILE(QSHONI/SOURCE) SRCMBR(SRCBLDC) REPLACE(*YES)`

`CALL PGM(QSHONI/SRCBLDC)`

# Installing QSHONI library via wget and creating command objects

Use this install method if you want to install from a save file object via wget

Run the following commands to copy the save file from github into a SAVF object

`CRTSAVF FILE(QGPL/QSHONI)`

From QSHELL/QPTERM or BASH run:

```
/QOpenSys/pkgs/bin/wget https://github.com/richardschoen/QshOni/releases/download/V1.0.5/qshoni.savf
--no-check-certificate -O  /qsys.lib/qgpl.lib/qshoni.file
```

Restore the QSHONI library

`RSTLIB SAVLIB(QSHONI) DEV(*SAVF) SAVF(QGPL/QSHONI)`

Build the QSHONI commands

***(Important co CHGJOB CCSID(37) before building from SAVF)***

`CHGJOB CCSID(37)`

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
      IFSSTDOUT(*NO)
      IFSFILE('/tmp/log.txt')
      IFSOPT(*REPLACE)
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

```Stdout Logging Note:``` During execution, the CL command always creates a temporary outfile in library QTEMP that gets automatically populated with standard output (stdout) from the QSH/PASE command process that gets run. The temporary stdout output file name is: ```QTEMP/STDOUTQSH```. If the file already exists for a subsequent run of the command, the ```QTEMP/STDOUTQSH``` temporary file is automatically cleared before running so each run gets a fresh copy of ```QTEMP/STDOUTQSH```. The ```QTEMP/STDOUTQSH``` temp file gets created automatically always, even if none of the switches such as: ```DSPSTDOUT, LOGSTDOUT, PRTSTDOUT or IFSSTDOUT``` are specified. 

**CMDLINE** - Qsh/Pase command line sequence to run. Semicolons can be used to run multiple commands.

**SETPKGPATH** - Add the IBM i Open Source Package path to PATH environment variable by calling QSHPATH command before running QSH/PASE commands. Default = *YES.

**DSPSTDOUT** - Display the outfile contents. Nice when debugging. 

**LOGSTDOUT** - Place STDOUT log entries into the current jobs job log. Use this if you want the log info in the IBM i joblog. All STDOUT entries are written as CPF message: **QSS9898**

**PRTSTDOUT** - Print STDOUT to a spool file. Use this if you want a spool file of the log output.

**DLTSTDOUT** - This option insures that the STDOUT IFS temp files get cleaned up after processing. All IFS log files get created in the /tmp/qsh directory.

**IFSSTDOUT** - Copy std output to an IFS file. Nice for aggregating log results to a file.

**IFSFILE** - IFS file for stdout results. Needs to be specified if IFSSTDOUT = *YES.

**IFSOPT** - IFS file option. *REPLACE = replace stdout IFS file. *ADD = Add to stdout IFS file.

**CCSID** - When using the iToolkit component for command access, I originally had some issues with CL commands not working correctly. However I don't currently remember exactly why. This may have been solved, however I recommend still passing a value of 37 unless you are in a non US country. If you set to `*SAME`, the CCSID will stay the same as your current job with no change.

**PRTSPLF** - This option holds the name of the spool file used when PRTSTDOUT = *YES. It's a nice way to customize the stdout log prints. ***Default = QSHEXECLOG***

**PRTUSRDTA** - This option holds the name of the spool file user data used when PRTSTDOUT = *YES. ***Default = *NONE ***

**PRTTXT** - This option holds the name of the spool file print txt to be used when PRTSTDOUT = *YES. ***Default = *NONE ***

**PRTHOLD** - This option determines if the spool file is held if one is generated when PRTSTDOUT = *YES. ***Default = *YES ***

**PRTOUTQ** - This option determines the output queue where the spool file will generated to when PRTSTDOUT = *YES. ***Default = *SAME ***

**OUTFILE** - Output physical file to receive STDOUT from the QSH/PASE command. Default file: ```QTEMP/STDOUTQSH```  This output file ```always gets created and populated```.

**MBROPT** - Output file option. Default: ```*REPLACE``` *REPLACE = replace outfile contents. *ADD = Add to outfile contents. Generally you should replace the file contents. If you want to append to a log file it's recommended to use the IFS output file option to write or append to an IFS file log. This is much more amenable to log readers or processors.

**PASEJOBNAM** - PASE fork thread job names. Set PASE_FORK_JOBNAME environment variable to set forked thread jobs to have a unique name other than: QP0ZSPWP which is the default. Set the value or *DEFAULT=QP0ZSPWP.

# Using the QSHEXECSRC CL command to call a Qsh/Pase command sequence from a classic IBM i source member

The following example calls a QShell source member QSHELL01 stored in source file QSHONI/SOURCE to run the ls command to list files for the /tmp directory: 

 ```
      QSHEXECSRC SRCFILE(QSHONI/SOURCE)
      SRCMBR(QSHELL01)      
      CMDPARM(' ')               
      DSPSTDOUT(*YES)         
      LOGSTDOUT(*NO)          
      PRTSTDOUT(*NO)          
      DLTSTDOUT(*YES)
      IFSSTDOUT(*NO)
      IFSFILE('/tmp/log.txt')
      IFSOPT(*REPLACE)
      PRTSPLF(QSHEXECLOG) 
      PRTUSRDTA(*NONE)    
      PRTTXT(*NONE)       
      RMVTMPSCR(*YES)            
      PROMPTCMD(*NO)                   
```

Sample QShell source member: ```QSHONI/SOURCE(QSHELL01)``` Type: TXT Text: QShell script to List Files in /tmp folder
```
cd /tmp
ls -l
```

# QSHEXECSRC command parms

**Overview** - This CL command can be used to run a QSH/PASE command shell script from a classic source physical file member and log the results appropriately.   

The use case would be for an app where you want to store your QShell/PASE/Python/PHP/Etc. scripts as part of your library source and execute those scripts directly from a source physical file.

```Stdout Logging Note:``` During execution, the CL command always creates a temporary outfile in library QTEMP that gets automatically populated with standard output (stdout) from the QSH/PASE command process that gets run. The temporary stdout output file name is: ```QTEMP/STDOUTQSH```. If the file already exists for a subsequent run of the command, the ```QTEMP/STDOUTQSH``` temporary file is automatically cleared before running so each run gets a fresh copy of ```QTEMP/STDOUTQSH```. The ```QTEMP/STDOUTQSH``` temp file gets created automatically always, even if none of the switches such as: ```DSPSTDOUT, LOGSTDOUT, PRTSTDOUT or IFSSTDOUT``` are specified. 

**SRCFILE** - Source physical file where QShell/PASE script is stored. 

**SRCMBR** - Source member name where QShell/PASE script is stored. Script is automatically copied to an IFS based temp file in IFS dir ```/tmp/qsh``` for execution. The IFS temp file is auto-deleted by default after it runs unless you specify *NO to the RMVTMPSCR parameter.    

Changes to your script source members can be made usig via the SEU, RDi or VS Code editors.   
 
**CMDPARM** - Command line parms to pass to the selected Qsh/Pase script that runs. If no parameters are needed simply pass ```' '``` for the CMDPARM value.    

Parameters can be delimited with double quotes if needed.   
```Ex: "parm1" "parm2" "parm3"```

**SETPKGPATH** - Add the IBM i Open Source Package path to PATH environment variable by calling QSHPATH command before running QSH/PASE commands. Default = *YES.

**DSPSTDOUT** - Display the outfile contents. Nice when debugging. 

**LOGSTDOUT** - Place STDOUT log entries into the current jobs job log. Use this if you want the log info in the IBM i joblog. All STDOUT entries are written as CPF message: **QSS9898**

**PRTSTDOUT** - Print STDOUT to a spool file. Use this if you want a spool file of the log output.

**DLTSTDOUT** - This option insures that the STDOUT IFS temp files get cleaned up after processing. All IFS log files get created in the /tmp/qsh directory.

**IFSSTDOUT** - Copy std output to an IFS file. Nice for aggregating log results to a file.

**IFSFILE** - IFS file for stdout results. Needs to be specified if IFSSTDOUT = *YES.

**IFSOPT** - IFS file option. *REPLACE = replace stdout IFS file. *ADD = Add to stdout IFS file.

**CCSID** - When using the iToolkit component for command access, I originally had some issues with CL commands not working correctly. However I don't currently remember exactly why. This may have been solved, however I recommend still passing a value of 37 unless you are in a non US country. If you set to `*SAME`, the CCSID will stay the same as your current job with no change.

**PRTSPLF** - This option holds the name of the spool file used when PRTSTDOUT = *YES. It's a nice way to customize the stdout log prints. ***Default = QSHEXECLOG***

**PRTUSRDTA** - This option holds the name of the spool file user data used when PRTSTDOUT = *YES. ***Default = *NONE ***

**PRTTXT** - This option holds the name of the spool file print txt to be used when PRTSTDOUT = *YES. ***Default = *NONE ***

**PRTHOLD** - This option determines if the spool file is held if one is generated when PRTSTDOUT = *YES. ***Default = *YES ***

**PRTOUTQ** - This option determines the output queue where the spool file will generated to when PRTSTDOUT = *YES. ***Default = *SAME ***

**OUTFILE** - Output physical file to receive STDOUT from the QSH/PASE command. Default file: ```QTEMP/STDOUTQSH```  This output file ```always gets created and populated```.

**MBROPT** - Output file option. Default: ```*REPLACE``` *REPLACE = replace outfile contents. *ADD = Add to outfile contents. Generally you should replace the file contents. If you want to append to a log file it's recommended to use the IFS output file option to write or append to an IFS file log. This is much more amenable to log readers or processors.  

**PASEJOBNAM** - PASE fork thread job names. Set PASE_FORK_JOBNAME environment variable to set forked thread jobs to have a unique name other than: QP0ZSPWP which is the default. Set the value or *DEFAULT=QP0ZSPWP.

**RMVTMPSCR** - This option determines if the temporary IFS script file is auto-deleted after running. Normally the selection should be *YES to delete the temp file. Otherwise specify *NO if you are debugging for some reason. ***Default = *YES ***  

**PROMPTCMD** - This option determines if the ```QSH``` command is prompted interactively for testing or review of the actual QShell command line with parameter values before running the command. Normally the selection should be *NO since prompting is only needed if testing. Specify *YES if you are debugging for some reason and want the QSH command to prompt on an interactive 5250 session before running. ***Default = *NO ***


# Using the QSHBASH CL command to call a bash command sequence

The following example calls the ls command to list files for the /tmp directory using the bash command: 

 ```
      QSHBASH CMDLINE('cd /tmp;ls')   
      DSPSTDOUT(*YES)         
      LOGSTDOUT(*NO)          
      PRTSTDOUT(*NO)          
      DLTSTDOUT(*YES)
      IFSSTDOUT(*NO)
      IFSFILE('/tmp/log.txt')
      IFSOPT(*REPLACE)
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

```Stdout Logging Note:``` During execution, the CL command always creates a temporary outfile in library QTEMP that gets automatically populated with standard output (stdout) from the QSH/PASE command process that gets run. The temporary stdout output file name is: ```QTEMP/STDOUTQSH```. If the file already exists for a subsequent run of the command, the ```QTEMP/STDOUTQSH``` temporary file is automatically cleared before running so each run gets a fresh copy of ```QTEMP/STDOUTQSH```. The ```QTEMP/STDOUTQSH``` temp file gets created automatically always, even if none of the switches such as: ```DSPSTDOUT, LOGSTDOUT, PRTSTDOUT or IFSSTDOUT``` are specified. 

**CMDLINE** - Bash command line sequence to run. Semicolons can be used to run multiple commands.

**SETPKGPATH** - Add the IBM i Open Source Package path to PATH environment variable by calling QSHPATH command before running QSH/PASE commands. Default = *YES.

**DSPSTDOUT** - Display the outfile contents. Nice when debugging. 

**LOGSTDOUT** - Place STDOUT log entries into the current jobs job log. Use this if you want the log info in the IBM i joblog. All STDOUT entries are written as CPF message: **QSS9898**

**PRTSTDOUT** - Print STDOUT to a spool file. Use this if you want a spool file of the log output.

**DLTSTDOUT** - This option insures that the STDOUT IFS temp files get cleaned up after processing. All IFS log files get created in the /tmp/qsh directory.

**IFSSTDOUT** - Copy std output to an IFS file. Nice for aggregating log results to a file.

**IFSFILE** - IFS file for stdout results. Needs to be specified if IFSSTDOUT = *YES.

**IFSOPT** - IFS file option. *REPLACE = replace stdout IFS file. *ADD = Add to stdout IFS file.

**CCSID** - When using the iToolkit component for command access, I originally had some issues with CL commands not working correctly. However I don't currently remember exactly why. This may have been solved, however I recommend still passing a value of 37 unless you are in a non US country. If you set to `*SAME`, the CCSID will stay the same as your current job with no change.

**PRTSPLF** - This option holds the name of the spool file used when PRTSTDOUT = *YES. It's a nice way to customize the stdout log prints. ***Default = QSHBASHLOG***

**PRTUSRDTA** - This option holds the name of the spool file user data used when PRTSTDOUT = *YES. ***Default = *NONE ***

**PRTTXT** - This option holds the name of the spool file print txt to be used when PRTSTDOUT = *YES. ***Default = *NONE ***

**PRTHOLD** - This option determines if the spool file is held if one is generated when PRTSTDOUT = *YES. ***Default = *YES ***

**PRTOUTQ** - This option determines the output queue where the spool file will generated to when PRTSTDOUT = *YES. ***Default = *SAME ***

**OUTFILE** - Output physical file to receive STDOUT from the QSH/PASE command. Default file: ```QTEMP/STDOUTQSH```  This output file ```always gets created and populated```.

**MBROPT** - Output file option. Default: ```*REPLACE``` *REPLACE = replace outfile contents. *ADD = Add to outfile contents. Generally you should replace the file contents. If you want to append to a log file it's recommended to use the IFS output file option to write or append to an IFS file log. This is much more amenable to log readers or processors.

**PASEJOBNAM** - PASE fork thread job names. Set PASE_FORK_JOBNAME environment variable to set forked thread jobs to have a unique name other than: QP0ZSPWP which is the default. Set the value or *DEFAULT=QP0ZSPWP.

# Using the QSHCURL CL command to call a curl command sequence

The following example calls the curl command to download the google home page site contents to an IFS file. You only need to pass the parms after curl

 ```
      QSHCURL CMDLINE('http://www.google.com -o /tmp/curlout.txt')   
      DSPSTDOUT(*YES)         
      LOGSTDOUT(*NO)          
      PRTSTDOUT(*NO)          
      DLTSTDOUT(*YES)
      IFSSTDOUT(*NO)
      IFSFILE('/tmp/log.txt')
      IFSOPT(*REPLACE)
      PRTSPLF(QSHEXECLOG) 
      PRTUSRDTA(*NONE)    
      PRTTXT(*NONE)       
```

The following example calls the curl command with the --help flag to display the curl parms available

```
QSHCURL CMDLINE('--help') DSPSTDOUT(*YES) 
```

# QSHCURL command parms

**Overview** - This CL command can be used to run a PASE curl command and log the results appropriately. 

The command is a convenience wrapper that can be used to call a curl command with QSHEXEC instead of having to type the following full curl command sequence prefix on a QSHEXEC command line: ***curl http://www.sitename.com -o /tmp/curlout.txt***

```Stdout Logging Note:``` During execution, the CL command always creates a temporary outfile in library QTEMP that gets automatically populated with standard output (stdout) from the QSH/PASE command process that gets run. The temporary stdout output file name is: ```QTEMP/STDOUTQSH```. If the file already exists for a subsequent run of the command, the ```QTEMP/STDOUTQSH``` temporary file is automatically cleared before running so each run gets a fresh copy of ```QTEMP/STDOUTQSH```. The ```QTEMP/STDOUTQSH``` temp file gets created automatically always, even if none of the switches such as: ```DSPSTDOUT, LOGSTDOUT, PRTSTDOUT or IFSSTDOUT``` are specified. 

```
curl must be installed in your PASE/QSH environment in /QOpensys/pkgs/bin before this will work
To install curl from qshell/bash:  yum install curl
```

**CMDLINE** - Curl command line parameters.

**SETPKGPATH** - Add the IBM i Open Source Package path to PATH environment variable by calling QSHPATH command before running QSH/PASE commands. Default = *YES.

**DSPSTDOUT** - Display the outfile contents. Nice when debugging. 

**LOGSTDOUT** - Place STDOUT log entries into the current jobs job log. Use this if you want the log info in the IBM i joblog. All STDOUT entries are written as CPF message: **QSS9898**

**PRTSTDOUT** - Print STDOUT to a spool file. Use this if you want a spool file of the log output.

**DLTSTDOUT** - This option insures that the STDOUT IFS temp files get cleaned up after processing. All IFS log files get created in the /tmp/qsh directory.

**IFSSTDOUT** - Copy std output to an IFS file. Nice for aggregating log results to a file.

**IFSFILE** - IFS file for stdout results. Needs to be specified if IFSSTDOUT = *YES.

**IFSOPT** - IFS file option. *REPLACE = replace stdout IFS file. *ADD = Add to stdout IFS file.

**CCSID** - When using the iToolkit component for command access, I originally had some issues with CL commands not working correctly. However I don't currently remember exactly why. This may have been solved, however I recommend still passing a value of 37 unless you are in a non US country. If you set to `*SAME`, the CCSID will stay the same as your current job with no change.

**PRTSPLF** - This option holds the name of the spool file used when PRTSTDOUT = *YES. It's a nice way to customize the stdout log prints. ***Default = QSHBASHLOG***

**PRTUSRDTA** - This option holds the name of the spool file user data used when PRTSTDOUT = *YES. ***Default = *NONE ***

**PRTTXT** - This option holds the name of the spool file print txt to be used when PRTSTDOUT = *YES. ***Default = *NONE ***

**PRTHOLD** - This option determines if the spool file is held if one is generated when PRTSTDOUT = *YES. ***Default = *YES ***

**PRTOUTQ** - This option determines the output queue where the spool file will generated to when PRTSTDOUT = *YES. ***Default = *SAME ***

**PASEJOBNAM** - PASE fork thread job names. Set PASE_FORK_JOBNAME environment variable to set forked thread jobs to have a unique name other than: QP0ZSPWP which is the default. Set the value or *DEFAULT=QP0ZSPWP.

# Using the QSHPYRUN CL command to run a Python script via QSHEXEC

The following example calls a helloworld.py script that write to STDOUT

 ```
      QSHPYRUN SCRIPTDIR('/pythonapps')       
      SCRIPTFILE('hello.py')           
      ARGS(Parm1 Parm2)              
      PYVERSION(3)                   
      DSPSTDOUT(*YES)         
      LOGSTDOUT(*NO)          
      PRTSTDOUT(*NO)          
      DLTSTDOUT(*YES)
      IFSSTDOUT(*NO)
      IFSFILE('/tmp/log.txt')
      IFSOPT(*REPLACE)
      PRTSPLF(QSHPYRUN) 
      PRTUSRDTA(*NONE)    
      PRTTXT(*NONE)       
```

# QSHPYRUN command parms

**Overview** - This CL command can be used to run a Python script via QSHEXEC and log the results appropriately.

```Stdout Logging Note:``` During execution, the CL command always creates a temporary outfile in library QTEMP that gets automatically populated with standard output (stdout) from the QSH/PASE command process that gets run. The temporary stdout output file name is: ```QTEMP/STDOUTQSH```. If the file already exists for a subsequent run of the command, the ```QTEMP/STDOUTQSH``` temporary file is automatically cleared before running so each run gets a fresh copy of ```QTEMP/STDOUTQSH```. The ```QTEMP/STDOUTQSH``` temp file gets created automatically always, even if none of the switches such as: ```DSPSTDOUT, LOGSTDOUT, PRTSTDOUT or IFSSTDOUT``` are specified. 

**SCRIPTDIR** - The IFS directory location for the Python script. **Ex: /python**

**SCRIPTFILE** - The script file name you want to call without the directory path. The PYRUN command puts it all together. **Ex: hello.py**

**ARGS** - Command line parameter argument list. Up to 40 - 200 byte argument/parameter values can be passed to a Python script call. Each parm is automatically trimmed. Do NOT put double quotes around the parms or your program call may get errors because your parameters get compromised with extra double quotes. The double quotes are already added automatically inside the CL command processing program. Single quotes are allowed around your parmaeter data though if desired:  Ex: **'My Parm Value 1' 'My Parm Value 2'**

**PYVERSION** - The Python version you want to use. It should be set to either **2 or 2.7** for Python 2 or **3, 3.6 or 3.9** for Python 3.

**PYPATH** - The this is the directory path to your Python binaries (python/python3). Hopefully you have already installed the Yum versions so the default path should be good. Leave value set to `*DEFAULT`. **Default= /QOpenSys/pkgs/bin**. The default path lives in the **PYPATH** data area in the **PYONI** library.

**SETPKGPATH** - Add the IBM i Open Source Package path to PATH environment variable by calling QSHPATH command before running QSH/PASE commands. Default = *YES.

**USEVENV** - Use virtual environment - If set to *YES, run your Python script using an existing Python virtual environment as specified in the Python virtual environment path. The IFS directory and virtual environment must exist. Default = *No.

```
Note: When using virtual environment, you will need to make sure the PYPATH data area value is set to ' ' or pass ' '   
to the PYPATH parameter to make sure the system level python binary does not picked up. Each venv has its own python executable
```

**VENVPATH** - Virtual environment path - Specify an existing IFS directory that also contains a valid Python virtual environment. Cannot be blank or non-existant if USEVENV=*yes or the QSHPYRUN command will fail.

**DSPSTDOUT** - Display the outfile contents. Nice when debugging. 

**LOGSTDOUT** - Place STDOUT log entries into the current jobs job log. Use this if you want the log info in the IBM i joblog. All STDOUT entries are written as CPF message: **QSS9898**

**PRTSTDOUT** - Print STDOUT to a spool file. Use this if you want a spool file of the log output.

**DLTSTDOUT** - This option insures that the STDOUT IFS temp files get cleaned up after processing. All IFS log files get created in the /tmp/qsh directory.

**IFSSTDOUT** - Copy std output to an IFS file. Nice for aggregating log results to a file.

**IFSFILE** - IFS file for stdout results. Needs to be specified if IFSSTDOUT = *YES.

**IFSOPT** - IFS file option. *REPLACE = replace stdout IFS file. *ADD = Add to stdout IFS file.

**CCSID** - When using the iToolkit component for command access, I originally had some issues with CL commands not working correctly. However I don't currently remember exactly why. This may have been solved, however I recommend still passing a value of 37 unless you are in a non US country. If you set to `*SAME`, the CCSID will stay the same as your current job with no change.

**PRTSPLF** - This option holds the name of the spool file used when PRTSTDOUT = *YES. It's a nice way to customize the stdout log prints. ***Default = QSHEXECLOG***

**PRTUSRDTA** - This option holds the name of the spool file user data used when PRTSTDOUT = *YES. ***Default = *NONE ***

**PRTTXT** - This option holds the name of the spool file print txt to be used when PRTSTDOUT = *YES. ***Default = *NONE ***

**PRTHOLD** - This option determines if the spool file is held if one is generated when PRTSTDOUT = *YES. ***Default = *YES ***

**PRTOUTQ** - This option determines the output queue where the spool file will generated to when PRTSTDOUT = *YES. ***Default = *SAME ***

**OUTFILE** - Output physical file to receive STDOUT from the QSH/PASE command. Default file: ```QTEMP/STDOUTQSH```  This output file ```always gets created and populated```.

**MBROPT** - Output file option. Default: ```*REPLACE``` *REPLACE = replace outfile contents. *ADD = Add to outfile contents. Generally you should replace the file contents. If you want to append to a log file it's recommended to use the IFS output file option to write or append to an IFS file log. This is much more amenable to log readers or processors.

**PASEJOBNAM** - PASE fork thread job names. Set PASE_FORK_JOBNAME environment variable to set forked thread jobs to have a unique name other than: QP0ZSPWP which is the default. Set the value or *DEFAULT=QP0ZSPWP.

**DEBUGCMD** - Debug QSHEXEC command - If set to *YES, your job must be running interactively and it will display the command line that QSHPYRUN composed to execute via QSHEXEC before it runs. This is good for debugging or you are curious what the exec QSHEXEC command will look like. Under the covers QSHPYRUN utilizes the QSHEXEC command to run the Python command line. 

# Using the QSHLOGSCAN CL command to scan the stdout outfile for the selected value after QSHEXEC has completed. 

The command returns a CPF9898 excape message if value not found. Otherwise a CPF9898 completion message. 

The following example scans the outfile log in file QTEMP/STDOUTQSH for a text value of ***successfully*** somewhere in any line of the log file output: 

 ```
      MONMSG MSGID(CPF9898) EXEC(DO)
      SNDPGMMSG MSG('Did not find string of success in program output.') TOUSR(RICHARD)
      ENDDO 
      QSHLOGSCAN SCANFOR('successfully')   
      EXACTMATCH(*NO)         
```      

# QSHLOGSCAN command parms

**Overview** - This CL command is a convenience command that can be used to scan a STDOUT log for a specific value to indicate success or failure.

**SCANFOR** - Text value to scan for on each line in the stdout outfile. The value passed IS case sensitive and must match the value in the log file.

**EXACTMATCH** - *YES - Value must match exactly and be the only thing on the selected line. *NO - At least one line must contain the value somewhere in the line. Good for generic matching.

# Using the QSHQRYTMP CL command to run a SELECT query and output the results to an OUTFILE. 

The command returns a CPF9898 excape message on error. Otherwise a CPF9898 completion message. 

The following example queries all the records from table QIWS/QCUSCTDT and places the result in to an output table named: SQLTMP0001 in library QTEMP.

 ```
      QSHQRYTMP SQL('SELECT * FROM QIWS/QCUSTCDT')   
           OUTFILE(SQLTMP0001)                  
           EMPTYERROR(*YES)                     
           PROMPT(*NO)                          
```      

# QSHQRYTMP command parms

**Overview** - This CL command is a convenience command that can be used to run an SQL data selection query and create an outfile of resulting data. 

**SQL** - Enter an SQL SELECT statement to query some specific data.

**OUTFILE** - This is the output file/table where data gets selected in to via an SQL query. The table will get automatically created as a result of the query if it doesn't exist. 

**EMPTYERROR** - This parameter determines whether a CPF9898 escape message is thrown if no records were selected by the query. *YES - Throw an escape message if no records. *NO - Don't throw an error if no records selected. Default - *YES

**PROMPT** - This parameter will interactively prompt the RUNSQL statement if desired. Only use this parameter in an interactive 5250 session. *YES - Prompt for RUNSQL command. *NO - Do not prompt for RUNSQL. Default - *NO

Note: The following data areas are auto-created in the current job library QTEMP to track resulting query info. You can retreive a resulting record count or the name of the outfile to check for existence in case it didn't get created for some reason such as query failure.
```
SQLQRYCNT - Query result record count. 
SQLQRYFIL - Output file created by the query.
SQLQRYLIB - Output file library for the file created by the query.
```

# QSHPATH command parms

**Overview** - This CL command is a convenience command to add the IBM i Open Source packages directory name to the PATH environment variable.

**PKGPATH** - Specify IFS location to open source packages. ***DEFAULT = /QOpenSys/pkgs/bin**

# QSHSETPROF command parms

**Overview** - This CL command is a convenience command to create open source profile files for a selected user ID in their home directory from template source files in ```QSHONI/SOURCE```:

```QSHPROFILE``` generates ```.profile```

```QSHBASHPRF``` generates ```.bash_profile``` 

```QSHBASHRC``` generates ```.bashrc```

The following example creates the QShell/PASE .profile, .bashrc and .bash_rc files for the USER1 user ID.

 ```
     QSHSETPROF USER(USER1)     
           PROFILE(*YES)   
           BASHPROFIL(*YES)
           BASHRC(*YES)    
           REPLACE(*NO)   
```      

The following example creates or replaces the QShell/PASE .profile, .bashrc and .bash_rc files for the USER1 user ID.

 ```
     QSHSETPROF USER(USER1)     
           PROFILE(*YES)   
           BASHPROFIL(*YES)
           BASHRC(*YES)    
           REPLACE(*YES)   
```      

**USER** - Specify an existing user profile you want to create profile files for.

**PROFILE** - This parameter is used to create a new .profile file for the selected user in /home/USERID. *YES - Create .profile. *NO - Don't create .profile. Default - *YES

**BASHPROFIL** - This parameter is used to create a new .bash_profile file for the selected user in /home/USERID. *YES - Create .bash_profile. *NO - Don't create .bash_profile. Default - *YES

**BASHRC** - This parameter is used to create a new .bashrc file for the selected user in /home/USERID. *YES - Create .bashrc. *NO - Don't create .bashrc. Default - *YES

**REPLACE** - This parameter is used to replace .profile, .bashrc or .bash_profile if they exist. *YES - Replace files if found. *NO - Don't replace files if found. Default - *NO

# QSHPORTCHK command parms

**Overview** - This CL command is a convenience command to use DB2 services to check if the selected TCP/IP port has an application running on it.

The following example checks to see if a Postgres server instance is running on port 5432. The command completes successfully if the port is active and sends a CPF9898 escape message if the port is not active. There's also a numeric data area in QTEMP named SQLQRYCNT that will be 0 if port is not active or non-zero if the port is active.

 ```
     QSHONI/QSHPORTCHK LOCALPORT(5432)     
           CONNTYPE(IPV4)      
           OUTFILE(TCPTMP001)  
```      

**LOCALPORT** - Specify a specific TCP/IP port number.

**CONNTYPE** - This parameter is used to specify the TCP/IP connection type of IPV4 or IPV6. Default - IPV4

**OUTFILE** - This parameter is used to specify a temporary output file to create in QTEMP library for the job. Default name - TCPTMP001

# QSHPORTEND command parms

**Overview** - This CL command is a convenience command to use DB2 services to end all jobs on a selected TCP/IP port if the port has an application running on it.

The following example checks to see if a web service instance is running on port 443. The command completes successfully if the port is active or the port is not active and shows a count of jobs ended. There's also a numeric data area in QTEMP named SQLQRYCNT that will contain the number of jobs ended for the port. It will be 0 if port is not active or non-zero if the port was active and jobs were ended.

 ```
     QSHONI/QSHPORTEND LOCALPORT(443)            
           CONNTYPE(IPV4)            
           OUTFILE(QTEMP/TCPTMPEND)  
```      

**LOCALPORT** - Specify a specific TCP/IP port number to check for active jobs.

**CONNTYPE** - This parameter is used to specify the TCP/IP connection type of IPV4 or IPV6. Default - IPV4

**OUTFILE** - This parameter is used to specify a temporary output file to create in QTEMP library for the job. Default name - TCPTMP001

# Using the QSHPYCALL CL command to run a Python script via QSHEXEC and return up to 10 - 255 character parameter values  

**Note: The QSHPYCALL command must be embedded into a CL program because it contains CL return variables.   

The following example calls a script named ```pycallparm1.py``` that returns parameters from within an existing program.   
```See CL sample QSHPYCALLT in the QSHONI library```

 ```
       DCL        VAR(&RETURN01) TYPE(*CHAR) LEN(255)     
       DCL        VAR(&RETURN02) TYPE(*CHAR) LEN(255)     
       DCL        VAR(&RETURN03) TYPE(*CHAR) LEN(255)     
       DCL        VAR(&RETURN04) TYPE(*CHAR) LEN(255)     
       DCL        VAR(&RETURN05) TYPE(*CHAR) LEN(255)     
       DCL        VAR(&RETURN06) TYPE(*CHAR) LEN(255)     
       DCL        VAR(&RETURN07) TYPE(*CHAR) LEN(255)     
       DCL        VAR(&RETURN08) TYPE(*CHAR) LEN(255)     
       DCL        VAR(&RETURN09) TYPE(*CHAR) LEN(255)     
       DCL        VAR(&RETURN10) TYPE(*CHAR) LEN(255)     

      QSHPYCALL SCRIPTDIR('/qshpython')       
      SCRIPTFILE('pycallparm1.py')           
      ARGS('--parm1=inputvalue1')              
      PYVERSION(3)                   
      DSPSTDOUT(*YES)         
      LOGSTDOUT(*NO)          
      PRTSTDOUT(*NO)          
      DLTSTDOUT(*YES)
      IFSSTDOUT(*NO)
      IFSFILE('/tmp/log.txt')
      IFSOPT(*REPLACE)
      PRTSPLF(QSHPYRUN) 
      PRTUSRDTA(*NONE)    
      PRTTXT(*NONE)
      RETURN01(&RETURN01)
      RETURN01(&RETURN02)
      RETURN01(&RETURN03)
      RETURN01(&RETURN04)
      RETURN01(&RETURN05)
      RETURN01(&RETURN06)
      RETURN01(&RETURN07)
      RETURN01(&RETURN08)
      RETURN01(&RETURN09)
      RETURN01(&RETURN10)
```

# QSHPYCALL command parms

**Overview** - This CL command can be used to run a Python script via QSHEXEC and return up to 10 parameter values from the STDOUt log info. Note: The CL command must be embeddedin a CL program since it returns parameter values to the calling CL, RPG or COBOL program. 

```Stdout Logging Note:``` During execution, the CL command always creates a temporary outfile in library QTEMP that gets automatically populated with standard output (stdout) from the QSH/PASE command process that gets run. The temporary stdout output file name is: ```QTEMP/STDOUTQSH```. If the file already exists for a subsequent run of the command, the ```QTEMP/STDOUTQSH``` temporary file is automatically cleared before running so each run gets a fresh copy of ```QTEMP/STDOUTQSH```. The ```QTEMP/STDOUTQSH``` temp file gets created automatically always, even if none of the switches such as: ```DSPSTDOUT, LOGSTDOUT, PRTSTDOUT or IFSSTDOUT``` are specified. 

**SCRIPTDIR** - The IFS directory location for the Python script. **Ex: /python**

**SCRIPTFILE** - The script file name you want to call without the directory path. The PYRUN command puts it all together. **Ex: hello.py**

**ARGS** - Command line parameter argument list. Up to 40 - 200 byte argument/parameter values can be passed to a Python script call. Each parm is automatically trimmed. Do NOT put double quotes around the parms or your program call may get errors because your parameters get compromised with extra double quotes. The double quotes are already added automatically inside the CL command processing program. Single quotes are allowed around your parmaeter data though if desired:  Ex: **'My Parm Value 1' 'My Parm Value 2'**

**PYVERSION** - The Python version you want to use. It should be set to either **2 or 2.7** for Python 2 or **3, 3.6 or 3.9** for Python 3.

**PYPATH** - The this is the directory path to your Python binaries (python/python3). Hopefully you have already installed the Yum versions so the default path should be good. Leave value set to `*DEFAULT`. **Default= /QOpenSys/pkgs/bin**. The default path lives in the **PYPATH** data area in the **PYONI** library.

**SETPKGPATH** - Add the IBM i Open Source Package path to PATH environment variable by calling QSHPATH command before running QSH/PASE commands. Default = *YES.

**USEVENV** - Use virtual environment - If set to *YES, run your Python script using an existing Python virtual environment as specified in the Python virtual environment path. The IFS directory and virtual environment must exist. Default = *No.

```
Note: When using virtual environment, you will need to make sure the PYPATH data area value is set to ' ' or pass ' '   
to the PYPATH parameter to make sure the system level python binary does not picked up. Each venv has its own python executable
```

**VENVPATH** - Virtual environment path - Specify an existing IFS directory that also contains a valid Python virtual environment. Cannot be blank or non-existant if USEVENV=*yes or the QSHPYRUN command will fail.

**DSPSTDOUT** - Display the outfile contents. Nice when debugging. 

**LOGSTDOUT** - Place STDOUT log entries into the current jobs job log. Use this if you want the log info in the IBM i joblog. All STDOUT entries are written as CPF message: **QSS9898**

**PRTSTDOUT** - Print STDOUT to a spool file. Use this if you want a spool file of the log output.

**DLTSTDOUT** - This option insures that the STDOUT IFS temp files get cleaned up after processing. All IFS log files get created in the /tmp/qsh directory.

**IFSSTDOUT** - Copy std output to an IFS file. Nice for aggregating log results to a file.

**IFSFILE** - IFS file for stdout results. Needs to be specified if IFSSTDOUT = *YES.

**IFSOPT** - IFS file option. *REPLACE = replace stdout IFS file. *ADD = Add to stdout IFS file.

**CCSID** - When using the iToolkit component for command access, I originally had some issues with CL commands not working correctly. However I don't currently remember exactly why. This may have been solved, however I recommend still passing a value of 37 unless you are in a non US country. If you set to `*SAME`, the CCSID will stay the same as your current job with no change.

**PRTSPLF** - This option holds the name of the spool file used when PRTSTDOUT = *YES. It's a nice way to customize the stdout log prints. ***Default = QSHEXECLOG***

**PRTUSRDTA** - This option holds the name of the spool file user data used when PRTSTDOUT = *YES. ***Default = *NONE ***

**PRTTXT** - This option holds the name of the spool file print txt to be used when PRTSTDOUT = *YES. ***Default = *NONE ***

**PRTHOLD** - This option determines if the spool file is held if one is generated when PRTSTDOUT = *YES. ***Default = *YES ***

**PRTOUTQ** - This option determines the output queue where the spool file will generated to when PRTSTDOUT = *YES. ***Default = *SAME ***

**OUTFILE** - Output physical file to receive STDOUT from the QSH/PASE command. Default file: ```QTEMP/STDOUTQSH```  This output file ```always gets created and populated```.

**MBROPT** - Output file option. Default: ```*REPLACE``` *REPLACE = replace outfile contents. *ADD = Add to outfile contents. Generally you should replace the file contents. If you want to append to a log file it's recommended to use the IFS output file option to write or append to an IFS file log. This is much more amenable to log readers or processors.

**PASEJOBNAM** - PASE fork thread job names. Set PASE_FORK_JOBNAME environment variable to set forked thread jobs to have a unique name other than: QP0ZSPWP which is the default. Set the value or *DEFAULT=QP0ZSPWP.

**DEBUGCMD** - Debug QSHEXEC command - If set to *YES, your job must be running interactively and it will display the command line that QSHPYRUN composed to execute via QSHEXEC before it runs. This is good for debugging or you are curious what the exec QSHEXEC command will look like. Under the covers QSHPYRUN utilizes the QSHEXEC command to run the Python command line. 

**RETURN01 - RETURN10** - These 255 character parameters can return values from the called Python script if it writes return values to the STDOUT log using the Python print() command.    

The special format we look for to return values from STDOUT is:     
```RETURNPARM01: I am return value 1```   
``` - ```   
```RETURNPARM10: I am return value 10```   

# Using the QSHCALL CL command to call a Qsh/Pase command sequence and return up to 10 - 255 character parameters.  

**Note: The QSHCALL command must be embedded into a CL program because it contains CL return variables.  

The following example calls a script named ```pycallparm1.py``` that returns parameters from within an existing program.   
```See CL sample QSHCALLT in the QSHONI library```

```
      DCL        VAR(&RETURN01) TYPE(*CHAR) LEN(255)     
      DCL        VAR(&RETURN02) TYPE(*CHAR) LEN(255)     
      DCL        VAR(&RETURN03) TYPE(*CHAR) LEN(255)     
      DCL        VAR(&RETURN04) TYPE(*CHAR) LEN(255)     
      DCL        VAR(&RETURN05) TYPE(*CHAR) LEN(255)     
      DCL        VAR(&RETURN06) TYPE(*CHAR) LEN(255)     
      DCL        VAR(&RETURN07) TYPE(*CHAR) LEN(255)     
      DCL        VAR(&RETURN08) TYPE(*CHAR) LEN(255)     
      DCL        VAR(&RETURN09) TYPE(*CHAR) LEN(255)     
      DCL        VAR(&RETURN10) TYPE(*CHAR) LEN(255)     

      QSHCALL CMDLINE('python3 /qshpython/pycallparm1.py --parm1=inputvalue1')   
      DSPSTDOUT(*YES)         
      LOGSTDOUT(*NO)          
      PRTSTDOUT(*NO)          
      DLTSTDOUT(*YES)
      IFSSTDOUT(*NO)
      IFSFILE('/tmp/log.txt')
      IFSOPT(*REPLACE)
      PRTSPLF(QSHEXECLOG) 
      PRTUSRDTA(*NONE)    
      PRTTXT(*NONE)       
      RETURN01(&RETURN01)
      RETURN01(&RETURN02)
      RETURN01(&RETURN03)
      RETURN01(&RETURN04)
      RETURN01(&RETURN05)
      RETURN01(&RETURN06)
      RETURN01(&RETURN07)
      RETURN01(&RETURN08)
      RETURN01(&RETURN09)
      RETURN01(&RETURN10)
```

# QSHCALL command parms

**Overview** - This CL command can be used to run a QSH/PASE command and log the results appropriately. 

```Stdout Logging Note:``` During execution, the CL command always creates a temporary outfile in library QTEMP that gets automatically populated with standard output (stdout) from the QSH/PASE command process that gets run. The temporary stdout output file name is: ```QTEMP/STDOUTQSH```. If the file already exists for a subsequent run of the command, the ```QTEMP/STDOUTQSH``` temporary file is automatically cleared before running so each run gets a fresh copy of ```QTEMP/STDOUTQSH```. The ```QTEMP/STDOUTQSH``` temp file gets created automatically always, even if none of the switches such as: ```DSPSTDOUT, LOGSTDOUT, PRTSTDOUT or IFSSTDOUT``` are specified. 

**CMDLINE** - Qsh/Pase command line sequence to run. Semicolons can be used to run multiple commands.

**SETPKGPATH** - Add the IBM i Open Source Package path to PATH environment variable by calling QSHPATH command before running QSH/PASE commands. Default = *YES.

**DSPSTDOUT** - Display the outfile contents. Nice when debugging. 

**LOGSTDOUT** - Place STDOUT log entries into the current jobs job log. Use this if you want the log info in the IBM i joblog. All STDOUT entries are written as CPF message: **QSS9898**

**PRTSTDOUT** - Print STDOUT to a spool file. Use this if you want a spool file of the log output.

**DLTSTDOUT** - This option insures that the STDOUT IFS temp files get cleaned up after processing. All IFS log files get created in the /tmp/qsh directory.

**IFSSTDOUT** - Copy std output to an IFS file. Nice for aggregating log results to a file.

**IFSFILE** - IFS file for stdout results. Needs to be specified if IFSSTDOUT = *YES.

**IFSOPT** - IFS file option. *REPLACE = replace stdout IFS file. *ADD = Add to stdout IFS file.

**CCSID** - When using the iToolkit component for command access, I originally had some issues with CL commands not working correctly. However I don't currently remember exactly why. This may have been solved, however I recommend still passing a value of 37 unless you are in a non US country. If you set to `*SAME`, the CCSID will stay the same as your current job with no change.

**PRTSPLF** - This option holds the name of the spool file used when PRTSTDOUT = *YES. It's a nice way to customize the stdout log prints. ***Default = QSHEXECLOG***

**PRTUSRDTA** - This option holds the name of the spool file user data used when PRTSTDOUT = *YES. ***Default = *NONE ***

**PRTTXT** - This option holds the name of the spool file print txt to be used when PRTSTDOUT = *YES. ***Default = *NONE ***

**PRTHOLD** - This option determines if the spool file is held if one is generated when PRTSTDOUT = *YES. ***Default = *YES ***

**PRTOUTQ** - This option determines the output queue where the spool file will generated to when PRTSTDOUT = *YES. ***Default = *SAME ***

**OUTFILE** - Output physical file to receive STDOUT from the QSH/PASE command. Default file: ```QTEMP/STDOUTQSH```  This output file ```always gets created and populated```.

**MBROPT** - Output file option. Default: ```*REPLACE``` *REPLACE = replace outfile contents. *ADD = Add to outfile contents. Generally you should replace the file contents. If you want to append to a log file it's recommended to use the IFS output file option to write or append to an IFS file log. This is much more amenable to log readers or processors.

**PASEJOBNAM** - PASE fork thread job names. Set PASE_FORK_JOBNAME environment variable to set forked thread jobs to have a unique name other than: QP0ZSPWP which is the default. Set the value or *DEFAULT=QP0ZSPWP.  

**RETURN01 - RETURN10** - These 255 character parameters can return values from the called Python script if it writes return values to the STDOUT log using the Python print() command.   

The special format we look for to return values from STDOUT is:     
```RETURNPARM01: I am return value 1```   
``` - ```   
```RETURNPARM10: I am return value 10```   
