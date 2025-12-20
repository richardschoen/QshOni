# QShell on i Version Info

## V1.0.1 - 8/18/2019
- Initial build

## V1.0.2 - 9/23/2020
- Added SETPKGPATH parameter to set IBM Open Source paths
 *DEFAULT = /QOpenSys/pkgs/bin
- Added PRTSPLF, PRTUSRDTA and PRTTXT parameters for personalizing
 the spool file when printing the stdout logs.

## V1.0.3 - 2/1/2021
- Added QSHBASH command to execute selected bash command line
 using QSHEXEC. The QSHBASH command passes through the selected
 command line to the bash command with: bash -c <cmdline>
 This is a convenience wrapper ovewr QSHEXEC to keep from having
 to type bash -c when you want to run bash commands.

## V1.0.4 - 3/3/2021                                                     
- Added IFSSTDOUT option to QSHEXEC to copy stdout to IFS file.        
- Added IFSSTDOUT option to QSHBASH to copy stdout to IFS file.        

## V1.0.5 - 4/11/2021                                        
- Added QSHIFSCHK to check for IFS files.                  
- Added QSHPYRUN command to run Python shell scripts.      

## V1.0.6 - 5/13/2021                                                    
- Added PRTHOLD parm to QSHEXEC, QSHBASH and QSHPYRUN to optionally    
 hold the printer spool file when generated. Previously it was always 
 HOLD-*YES.                                                           
- Added PRTOUTQ parm to QSHEXEC, QSHBASH and QSHPYRUN to optionally    
 send spool output to a specific output queue. Default is *SAME which 
 will use the current job output queue.                               

## V1.0.7 - 7/13/2021                                                    
- Added various python version numbers to QSHPYRUN/QSHPYRYNC to handle 
 the new Python 3.9 being installed side-by-side with 3.6.            

## V1.0.8 - 7/16/2021                                                   
- Added QSHQRYTMP command to use SQL to create temp files as needed   
for reporting or other use cases. This command is useful because    
often a single SQL query can gather data for ap process. This       
command extends that query to create an output file for use by      
an RPG, CL or COBOL program after the query result file is created. 

## V1.0.9 - 10/26/2021                                                  
- Added parm to QSHPATH to place open source package path at begin or 
 end of the PATH as set in the QSHPATHLOC data area. DFT=*BEGIN      

## V1.0.10 - 11/10/2021                                                 
- Added parm AUT(*INDIR) to CPYTOSTMF commands in QSHEXECC. This will 
 inherit output directory permissions when a log file is copied.     
 Default CPYTOSTMF behavior (*DFT) is to set *PUBLIC access to *NONE.

## V1.0.11 - 03/16/2022
- Added QSHSETPROF command to create default PASE profile files
 .profile, .bash_profile and .bashrc for the selected user.
 The .profile sets default paths for STRQSH or default SSH shell.
 .bash_profile sets default paths for bash when it's default SSH shell.
 .bashrc sets default paths for bash when bash called from SSH shell
 and bash is not the default shell.

## V1.0.12 - 04/06/2022
- Created QSHCURL command to run the curl command.

## V1.0.13 - 08/08/2022                                                       
- Created QSHPORTCHK command to check for active IPV4 or IPV6 TCP/IP port.  

## V1.0.14 - 10/27/2022                                                                             
- Created QSHPORTEND command to end jobs on active IPV4 or IPV6 TCP/IP port.                      

## V1.0.15 - 11/28/2022                                                                                  
- Updated desc on QSHPYRUN PRTSTDOUT command from:                                          
 Prt standard output on errors to                                                          
 Print standard output result                                                              

## V1.0.16 - 11/28/2022                                                                                          
- Added OUTFILE and MBROPT parms to QSHEXEC, QSHBASH and QSHPYRUN commands.                 
 Default outfile is: QTEMP/STDOUTQSH. You can specifiy an outfile be placed in any library.
 However library QTEMP is job agnostic so best to always create an outfile in QTEMP and    
 copy it if saving to an IFS file isn't an option.                                         
 Default outfile member option is: *REPLACE  (Available options - *ADD/*REPLACE)           
 You can replace or add to the contents of an outfile. Generally *REPLACE should be used.  
 However you can copy the outfile anywhere you want after the commands complete.           

## V1.0.17 - 12/3/2022                                                                               
- Added USEVENV and VENVPATH variables to the QSHPYRUN command.                                    
 If USEVENV value is *YES then a valid virtual environment base directory name must be specified  
 for the VENVPATH value. And it must be configured as a Python virtual environment.               

## V1.0.18 - 2/25/2023                                                                        
- Added QSHEXECSRC command to execute a QShell .sh script stored in a source physical file. 

## V1.0.19 - 3/18/2023                                                                                 
- Updated QSHPYRUNC to support running python binary without a qualified path. The qualified path    
 can apparently cause issues when running python in a virtual environment. The wrong python binary  
 may get called.                                                                                    
- When using QSHPYRUN with a virtual environment, the PYPATH parm can be changed from *DEFAULT to ' '
 or change the PYPATH data area to blanks instead of /QOpenSys/pkgs/bin and the path will never     
 get qualified and will always use the current binary search path.                                  

## V1.0.20 - 3/24/2023                                                                                    
- Updated QSHPYRUN to support a 'cd /scriptpath' directory change before running a Python script.       
 The new CHGSCRDIR parameter will support fully qualifying or not qualifying entire script path.       
 If *NO is specified, script path is fully qualified. (Default and same as previous versions)          
 If *YES is specified, a 'cd /scriptpath" is performed and script path is not fully qualified.         

## V1.0.21 - 4/13/2023                                                    
- Updated QSHEXECC to create data area QTEMP/QSHRTNCOD to capture the    
 QSH exit return code value so it can be checked from a CL/RPG program.

## V1.0.22 - 4/14/2023                                                  
- Updated QSHEXECC to create data area QTEMP/STDOUTIFS to capture the 
 temporary STDOUT IFS file name used to capture QSH/PASE output.     
 This value is only useful if you use the DLTSTDOUT(*NO) value.      
 If DLTSTDOUT(*YES) is specified, the temp file gets removed after   
 the process completes, although the STDOUT contents do get copied   
 to temp file QTEMP/STDOUTQSH before removing the temporary IFS file.
 Under normal circumstances you should always use DLTSTDOUT(*YES).   

## V1.0.23 - 5/1/2023                                                   
- Added PASEJOBNAM parm to the following commands:                    
QSHEXEC, QSHEXECSRC, QSHBASH, QSHPYRUN, QSHCURL                     
If set to *DEFAULT, standard thread names are used: QP0ZSPWP        
If value is set for job name, that job name is applied to           
all forked/spawned thread jobs by automatically adding the          
environment variable PASE_FORK_JOBNAME with selected job name   
before launching and thread jobs. 

## V1.0.24/V1.0.25 - 8/4/2023
- Created QSHPYCALL command. This is a variation of the QSHPYRUN cmd. It
 will run a Python script and return parameter values as long as they
 are prefixed in STDOUT with: RETURNPARM01: - RETURNPARM10:
 Statements can be written to STDOUT using the print() statement
 in a Python script. See sample script: ```pycallparl1.py`` on the
 GitHub site.
 Example STDOUT value: "RETURNPARM01:I am return value 1"
 Would return: "I am return value 1" to the QSHPYCALL command
 return parameter 1.
 QSHPYCALL is mainly a convenience wrapper for RPG/CL/COBOL developers
 who might want to do some quick work in Python and return it for
 use in their RPG/CL/COBOL programs. They are generally used to the
 call/parm convention of RPG/CL/COBOL programming.    

- Created QSHCALL command. This is a variation of the QSHEXEC cmd. It  
 will run a Python script and return parameter values as long as they 
 are prefixed in STDOUT with: RETURNPARM01: - RETURNPARM10:           
 Statements can be written to STDOUT using the print() statement      
 in a Python script. See sample script: pycallparl1.py on the         
 GitHub site.                                                         
 Example STDOUT value: "RETURNPARM01:I am return value 1"             
 Would return: "I am return value 1" to the QSHPYCALL command         
 return parameter 1.                                                  
 QSHCALL is mainly a convenience wrapper for RPG/CL/COBOL developers  
 who might want to do some quick work in Python and return it for     
 use in their RPG/CL/COBOL programs. They are generally used to the   
 call/parm convention of RPG/CL/COBOL programming.   

- Qualify RUNSQL command as QSYS/RUNSQL in QSHQRYTMPC.
  Ran into a case where a customer has their own custom RUNSQL
  command which was totally different than QSYS/RUNSQL in the
  system library list. This cause the command to crash due to
  having different parameters. Qualifying RUNSQL to QSYS should
  resolve this issue.

## V1.0.26 - 12/24/2023                                                  
- Created QSHCPYSRC command to copy source member to IFS file.         
 This will allow developers to store Python and other script files    
 in a source physical file if desired and copy to IFS at runtime      
 as a temporary file.                          

## V1.0.27 - 4/28/2024                                               
- Added QSHBASHSRC command to execute a QShell .sh script stored in
 a source physical file. This is essentially a bash version of the
 QSHEXECSRC command which runs a script via QShell.               

## V1.0.28 - 5/24/2024
- Added QSHONISRV service program to execute pase commands with
 QSHEXEC OR QSHBASH.
- Added QSHONIPR01 RPG program to test the QSHEXEC service program call 
 and process the STDOUT results outfile in a single program.           
- Added QSHONIPR02 RPG program to test the QSHBASH service program call 
 and process the STDOUT results outfile in a single program.           

## V1.0.29 - 7/2/2024                                                
- Added binder source to the QSHONISRV service program build so    
 signature order stays consistent as we add new procedures to     
 the service program.            
- Added QSHCALL subprocedure to the QSHONISRV service program      
 so that RPG programs can run a script and return up to 10        
 parameters directly to the RPG program. This is a complement     
 to the QSHCALL CL command that does the same thing from a CL     
 program.
- Added QSHONIPR03 RPG program to test the QSHCALL service program 
 call to return parameters.                                       
- Added library name qualifer to the CL command processing program    
 build process. This will insure that the version of the command     
 processing program in QSHONI library always gets used in case       
 any objects exist with the same name in your own libraries.         

## V1.0.30 = 7/16/2024
- Added QSHIFSSIZ command to retrieve the file size and allocated size of an IFS file. 

## V1.0.31 = 7/23/2024                                                    
- Updated QSHIFSSIZ return for size values to be 15 instead of 9 digits.
 This stages the command to be upgraded to use stat64 at some point.   
 CL commands can only return 15 positions in a *DEC type field so I'm  
 not sure the best way to return larger fields when we switch to       
 using stat64. Probably will introduce RPG to the mix for the call     
 to stat64. Right now the return values will still be limited to the     
 binary 4 max which appears to be: 2,147,483,647                       

## V1.0.32 = 7/26/2024                                                
- Added QSHSAVLIB command to save library to save file format       
 in an IFS file. Creates data area QSHONI/SAVFDIR and defaults     
 it to /tmp/savfqsh if IFS dir not found. You can change to        
 your own default dir. The default dir is used for save file       
 automatic naming if special keywords used for save file name.     
 *DATETIME - library_yyyymmdd_hhmmss.savf is the save file name.   
 *DATE - library_yyyymmdd.savf is the save file name.              

- Added QSHSAVIFS command to save IFS objects to save file format   
 in an IFS file. Creates data area QSHONI/SAVFDIR and defaults     
 it to /tmp/savfqsh if IFS dir not found. You can change to        
 your own default dir. The default dir is used for save file       
 automatic naming if special keywords used for save file name.     
 *DATETIME - savfprefix_yyyymmdd_hhmmss.savf is the save file name.
 *DATE - savfprefix_yyyymmdd.savf is the save file name.           

- Added QSHQRYSRC command to use SQL to create temp files as needed 
 for reporting or other use cases. This command differs from       
 QSHQRYTMP in that it gets the SQL query information from a source
 physical file member or an IFS file instead via SQL statement    
 entry on the command.  
                                                                 
 Sample command to query QIWS.QCUSTCDT via SQLTEST1 source member:
 ```
QSHONI/QSHQRYSRC SQLLOC(*SRCMBR)
                 SRCFILE(QSHONI/SOURCE)
                 SRCMBR(SQLTEST1)
```                                                                
- Updated QSHQRYTMP command to make sure prompting works for SQL
 statement if Prompt=*YES.  

## V1.0.33 - 8/6/2024                                                
- Updated QSHIFSSIZ command to use stat64 internally. Now we can return 
 object lengths up to 15 positions with 0 decimals from the CL command. 
 15 positions is the CL program max, although a CL command seems to allow 
 a return of up to 20 positions.

## V1.0.34 - 11/22/2024                                                  
- Added Python 3.13 to version parm in QSHPYRUN and QSHPYCALL commands.

## V1.0.35 - 1/15/2025
- Added QSHIFSSCAN command. This command can be used to scan an IFS file for specific values. The main intent is to be able to scan a STDOUT or STDERROR log file as needed for information to see if a value or value(s) exist. Currently multiple values can be entered to search for, but the command ends successfully if any of the exact matching values are found in the selected IFS file.

## V1.0.36 - 2/5/2025
- Added QSHQRYAID command. This command can be used to add a unique ID field to an output file (OUTFILE) created by the QSHQRYTMP or QSHQRYSRC commands.   

- Updated QSHQRYTMP and QSHQRYSRC commands to allow passing of soft coded parameter values.   

- Updated QSHQRYTMP and QSHQRYSRC commands to allow optional adding of a unique ID field to the generated output file.   

- Added RUNSQLPRM command to allow for dynamically running SQL action statements with parameter value substitution. Great for running variable SQL action statements and commands from a CL program. Uses RUNSQL internally.

Sample insert SQL command using replacement parameter markers
```
RUNSQLPRM SQL('insert into qiws/qcustcdt (cusnum,lstnam) values(@@CUSNUM,''@@LSTNAM'')')                  
          PARMS(@@CUSNUM @@LSTNAM)                          
          PARMVALS(55 Schoen)                               
          PROMPT(*YES)
```

- Added RUNSQLSRC command to allow for dynamically running SQL action scripts from source with parameter value substitution. Great for running variable SQL action statements and commands in an SQL script stored in a source member from a CL program. Uses RUNSQLSTM internally.

## V1.0.37 - 5/16/2025
- Added ```QSHGETPR2``` command. This command is an enhanced version of the QSHGETPARM command that can be used to get STDOUT return parameters from a call to ```QSHEXEC``` or ```QSHBASH```. There are parameters to optionally write the return parameter values to the joblog as *DIAG messages or write the return parameter values to auto-created temporary data areas in QTEMP (or another specified library). Data areas are named: ```RTNPARMxx (RTNPAMR01-RTNPARM10)```. There is a max of 10 returned parameters currently. See V1.0.25 for additional definition on this functionality. 
The base use case is: The developer can send return parms from the QSH/PASE call back into the regular job so they can be consumed/utilized form the original CL/RPG calling program.

- Updated ```QSHPHPRUN```, ```QSHPYRUN``` and ```QSHPYCALL``` commands to include a parameter to make implied double quotes optional for the 40 parameter agument values. Parameter delimiter values are still set to double quote by default for compatability, but can be omitted by setting to *NONE if you want full control of the argument formatting from your CL or RPG code. 

- Example of specifying ```*DBLQUOTE``` for the ```ARGDLM``` parameter to control the parameter delimiter used for ```QSHPHPRUN```, ```QSHPYRUN``` and ```QSHPYCALL```: 
If you pass a value of: ```PARM VALUE 01``` it will get automatically paired with double quotes like this: ```"PARM VALUE 01"```.       

- Example of specifying ```*NONE``` for the ```ARGDLM``` parameter to fully control where you want quotes in your parameters for ```QSHPHPRUN```, ```QSHPYRUN``` and ```QSHPYCALL```:  
If you pass a value of: ```--parm01="PARM VALUE 01"``` it will stay as originally formatted with quotes left in place where you put them when passed to the python command line, therefore the parameter will get passed to Python as desired.       

## V1.0.38 - 5/29/2025
- Added bash command line delimiter parameter for ```QSHBASH``` command. Defaults to single quote which is what it has been since inception.  Also added a debug parameter so developer can prompt and see the actual bash command line being called.

## V1.0.39 - 6/2/2025
- Added the ```PHPCMD``` option argument to the ```QSHPHPRUN``` command so we can run the php cli in debug mode without having to type: ```php -d error_log=``` on the PHP command line. *DEFAULT runs the ```php``` command as normal. *DEBUG runs the ```php -d error_log=``` command so we can capture any errors that occur into the STDOUT logging output. This is a convenience item for people running php command line (CLI) mode php scripts. 

## V1.0.40 - 6/18/2025
- Added command UIM help panel group documentation for CL commands. Also added the command doc info to the command creations for QSHEXEC and QSHBASH. Currently covered are QSHEXEC and QSHBASH. Contributed by Scott Schollenberger.
  
## V1.0.41 - 10/17/2025
- Removed unnecessary diagnostic joblog message from RUNSQLPRMC. There was a message sending SQL source file name info to the joblog as a *DIAG message. This message was not problematic, but also not necessary since the RUNSQLPRM command does not use a source file. An interactive SQL statement is passed to the command to run. This was essentially a cosmetic update. 

## V1.0.42 - 11/5/2025
- Added new parameters and functionality to QSHQRYSRC query command.    
By default all comments are stripped from the SQL query source member dynamically before the query is run. This way we can create SQL queries in ACS and copy/paste into a source member for storage without having to remove the comments. Then queries can easily be created in ACS and stored in their original format. Comment lines start with -- characters. Inline comments are also stripped. 
Inline comments strip all characters to the right of the comment -- placeholder characters.    

DLTCMTLINE - Delete comment line from source member. This parameter determines if empty source lines are removed from the SQL source member after comment info has been stripped from a line. *YES is the default and will strip comment lines from the SQL source member. *NO will simply strip comments, but leave any blank lines intact. The runtime effect should usually be the same.

DSPTMPSRC - Display the temporary source member after it's been prepared for runtime. This is a nice way to preview the SQL query that will actually run after comments were stripped from the SQL source. Good for troubleshooting. *NO - Do not display the SQL temporary source member. *YES - Display the SQL temporary source member. 

- Added new parameters to RUNSQLSRC query command.    
By default all comments are stripped from the SQL query source member dynamically before the query is run. This way we can create SQL queries in ACS and copy/paste into a source member for storage without having to remove the comments. Then queries can easily be created in ACS and stored in their original format. Comment lines start with -- characters. Inline comments are also stripped. 
Inline comments strip all characters to the right of the comment -- placeholder characters.    

DLTCMTLINE - Delete comment line from source member. This parameter determines if empty source lines are removed from the SQL source member after comment info has been stripped from a line. *YES is the default and will strip comment lines from the SQL source member. *NO will simply strip comments, but leave any blank lines intact. The runtime effect should usually be the same.

DSPTMPSRC - Display the temporary source member after it's been prepared for runtime. This is a nice way to preview the SQL query that will actually run after comments were stripped from the SQL source. Good for troubleshooting. *NO - Do not display the SQL temporary source member. *YES - Display the SQL temporary source member. 

Added special *SRCMBR keyword for SPLF, USRDTA and USRDFNDTA. If PRTTMPSRC is selected, the report spool file, user data and user defined data can be set to the SQL source member name if desired by using the *SRCMBR special keyword. USRDTA and USRDFNDTA now default to: *SRCMBR.    
Previous default for spool file was: RUNSQLSRCP.    
Previous default for usr data was: RUNSQLSRC.   
Previous default for user defined data was: RUNSQLSRC.   

## V1.0.43 - 11/7/2025
Merged pull request for QSHPYCALL command to remove unuused parameter PARMDLM which is unused.

## V1.0.44 - 12/10/2025
Created new commands for listing active jobs and determining how many instances of an active job there are.   

QSHJOBLIST - Create an outfile list of selected jobs on the system. By default the command lists all jobs to the outfile. However a filter can be applied.    

The following example lists all jobs active on the system named: ADMIN   
```QSHJOBLIST QRYFILTER('JOBNAME LIKE ''ADMIN''')  ``` 

QSHJOBACT - Locate selected active jobs. Use this command to determine how many instances of a selected job name or generic pattern are active. This can be useful if you triggered a subsystem or app shutdown and need to know when all of the named jobs are ended.  

The following example lists all jobs active on the system named: ADMIN. The count is placed into a data area named: ```QTEMP/JOBACTCNT```    
```QSHJOBACT QRYFILTER('JOBNAME LIKE ''ADMIN''') EMPTYERROR(*NO)  ``` 

### Overview of QSYS2.ACTIVE_JOB_INFO() for QSHJOBLIST and QSHJOBACT
If the QSHJOBLIST and QSHJOBACT SQL fails for some reason, you could be missing appropriate PTF groups. See the following link:   
https://www.ibm.com/support/pages/qsys2activejobinfo  

## V1.0.45 - 12/12/2025
Created QSHENDWEB command for shutting down web server via ENDTCPSVR command and then monitoring to make sure the jobs end for a selected period of time. 

QSHENDWEB - End web server instance and monitor for jobs to end.

## V1.0.46 - 12/20/2025
Created QSHSCP command for transferring files over an SSH connection as an alternative to SFTP. 




