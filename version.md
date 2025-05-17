# QShell on i Version Info

## V1.0.1 - 8/18/019
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

- Example of specifying ```*DBLQUOTE``` for the ```ARMDLM``` parameter to control the parameter delimiter used for ```QSHPHPRUN```, ```QSHPYRUN``` and ```QSHPYCALL```: 
If you pass a value of: ```PARM VALUE 01``` it will get automatically paired with double quotes like this: ```"PARM VALUE 01"```.       

- Example of specifying ```*NONE``` for the ```ARMDLM``` parameter to fully control where you want quotes in your parameters for ```QSHPHPRUN```, ```QSHPYRUN``` and ```QSHPYCALL```:  
If you pass a value of: ```--parm01="PARM VALUE 01"``` it will stay as originally formatted with quotes left in place where you put them when passed to the python command line, therefore the parameter will get passed to Python as desired.       

