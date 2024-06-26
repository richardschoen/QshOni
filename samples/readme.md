# QSHONI sample commands

This section contains useful sample commands that utilize the QSHONI library commands. 

These commands are not shipped as part of the core QSHONI library code.

## GREPSRCLIB CL Command - Search Library Source Members using Grep
This command uses the QSHEXEC command internally to wrap the ```grep QShell``` utility to allow selected source libraries, files and members to be scanned for a text string value based on an IFS file pattern. The ```-i``` and ```-n``` flags are used internally so scans are case insensitive and include the line number where the selected value is found in the scanned file.    

grep scan output results are written to the ```STDOUTQSH``` outfile in ```QTEMP``` and optionally to an IFS output file, spool file or the job log. 

The following example scans ```all source members``` in source file ```QCLSRC``` in library ```MYDEVLIB``` for the following string value: ```monmsg``` and displays the results on screen and to a spool file.

```
 GREPSRCLIB SRCLIBRARY(MYDEVLIB)      
            SRCFILE(QCLSRC)           
            SEARCHFOR(monmsg)         
            PROMPTCMD(*NO)            
            DSPSTDOUT(*YES) 
            PRTSTDOUT(*YES)          
```

Sample results.  
```
/QSYS.LIB/MYDEVLIB.LIB/QCLSRC.FILE/TEST001C.MBR:19:  MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))  
/QSYS.LIB/MYDEVLIB.LIB/QCLSRC.FILE/TEST002C.MBR:27:  MSGID(CPF0000) EXEC(DO)  
/QSYS.LIB/MYDEVLIB.LIB/QCLSRC.FILE/TEST004C.MBR:44:  MSGID(CPF0000) EXEC(DO)  
/QSYS.LIB/MYDEVLIB.LIB/QCLSRC.FILE/TEST006C.MBR:22:  MSGID(CPF0000) EXEC(GOTO CMDLBL(ERRORS))  
```

The following example scans ```all source members``` in source file ```QCLSRC``` in library ```MYDEVLIB``` for the following string value: ```monmsg``` and displays the results on screen and to a spool file. Prior to running the command the prompt for the QSHEXEC command is displayed so the user can see the grep command used to scan the selected files.

Example grep command which is case insensitive (```-i```) and includes line numbers (```-n```) by default:   
```/usr/bin/grep -i -n "monmsg" /QSYS.LIB/MYDEVLIB.LIB/QCLSRC.FILE/*.MBR```                                                     

```
 GREPSRCLIB SRCLIBRARY(MYDEVLIB)      
            SRCFILE(QCLSRC)           
            SEARCHFOR(monmsg)         
            PROMPTCMD(*NO)            
            DSPSTDOUT(*YES) 
            PRTSTDOUT(*YES)   
            PROMPTCMD(*YES)       
```

## STRNGINX CL Command - Start NGINX Web Server
This command starts the NGINX web server.   

The following sample starts NGINX in its default IFS location.   

```
STRNGINX NGINXBIN('/QopenSys/pkgs/bin/nginx')            
         NGINXCONF('/QOpenSys/etc/nginx.conf')                         
```

The following example submits STRNGINX to batch using a specific NGINX configured user profile of NGINX1.  

```
SBMJOB CMD(STRNGINX NGINXBIN('/QopenSys/pkgs/bin/nginx') PRTSTDOUT(*YES) NGINXCONF('/QOpenSys/etc/nginx/nginx.conf'))   
        JOB(STRNGINX) JOBQ(QUSRNOMAX) USER(NGINX1)
```

## ENDNGINX CL Command - End NGINX Web Server
This command ends the NGINX web server.   

The following sample ends NGINX using the config file it was started with.  

```
ENDNGINX NGINXBIN('/QopenSys/pkgs/bin/nginx')            
         NGINXCONF('/QOpenSys/etc/nginx.conf')                         
```                                                         

The following example submits ENDNGINX to batch using a specific NGINX configured user profile of NGINX1.  

```
SBMJOB CMD(ENDNGINX NGINXBIN('/QopenSys/pkgs/bin/nginx') PRTSTDOUT(*YES) NGINXCONF('/QOpenSys/etc/nginx/nginx.conf'))   
        JOB(ENDNGINX) JOBQ(QUSRNOMAX) USER(NGINX1)
```

## DB2 CL Command
This command wraps the DB2 QShell utility and writes the results to the IFS. The DB2UTIL command is a little more functional because it will write as delimited csv or json format but some may want to use the db2 command instead. If you use db2 you will haveto parse the file yourself for columns. It generally works to determine column widths based on the -------- column headers which generally match the data width. There is also a record count at the end. 

The following example queries QIWS/QCUSTCDT to a file in the IFS.   

```
DB2 SQL('select * from qiws.qcustcdt') 
    GENOPT('-v')                       
    OUTPUTFILE('/tmp/test.txt')        
    OPTION(*REPLACE)                   
```


# Using the PGDUMP CL command to back up a Postgres database to an IFS output file

Log in as the ```POSTGRES``` user profile on an IBM i 5250 session or submit the command as the ```POSTGRES``` user or other authorized Postgres database user.

The following example calls the Postgres pg_dump command internally to back up the selected ```gitbucket```database. After the backup the ```/QOpenSys/pkgs/bin/tar -tvf``` command is run automatically to validate that the backup output tar file is not corrupted.

```
      PGDUMP DATABASE(gitbucket) 
      OUTPUTFILE('/tmp/gitbucketbackup-20220811.tar')    
      FORMAT('t')
      REPLACE(*NO)
```

# PGDUMP command parms

**Overview** - This CL command can be used to run a Postgres pg_dump command to back up the selected Postgres database to a tar file and validate the tar file after the backup is complete to make sure it's not corrupted.

**DATABASE** - Enter a valid existing Postgres database name. 

**OUTPUTFILE** - IFS file for the tar output file that gets created from the pg_dump command.

**FORMAT** - The output format for the pg_dump command. ***Default - 't' to output in tar format. ***

**REPLACE** - Replace existing IFS output file option. *YES = replace IFS file. *NO = Fail if file already exists. ***Default = *NO ***


# Using the PGRESTORE CL command to restore a Postgres database from an IFS output file

The Postgres database must already exist and will be replaced. Or a new empty database must be created by the postgres user via the Postgres ```psql``` before restoring.

Log in as the ```POSTGRES``` user profile on an IBM i 5250 session or submit the command as the ```POSTGRES``` user or other authorized Postgres database user.

The following example calls the Postgres pg_restore command internally to restore the selected database from the selected IFS tar file.

```
          PGRESTORE DATABASE(gitbucket)   
          INPUTFILE('/tmp/gitbucketbackup-20220811.tar')    
          OPTIONS('-c')         
          PROMPT(*NO)
```

# PGRESTORE command parms

**Overview** - This CL command can be used to run a Postgres pg_restore command to restore a Postgres database from an IFS output file.

**DATABASE** - Enter a valid existing Postgres database name. (If restoring to a new database, the database must be created via psql prior to restoring the database.)

**INPUTFILE** - IFS tar backup file that gets restored via the pg_restore command.

**OPTIONS** - Restore options. Example: ```-c``` will clear the database of all objects before restoring and is a good idea to replace an existing database. Only use the ```-c``` option on a database that already contains objects. Otherwise the restore may fail on the first try. However a second restore try may work. ***Default = blank for no options ***

**PROMPT** - On an interactive 5250 job prompt the QSHBASH command so the user can see what the QSH/PASE restore command line looks like. This might be used when testing or debugging a new restore command call. *YES = Prompt for QSHBASH. *NO = No prompting for QSHBASH. ***Default = *NO ***


# Using the GITPORTC CL command to check TCP/IP ports for selected app server

This CL program sample can be used to check ports for specific TCP/IP application servers ports being active.

Modify as needed to fit your port check requirements.

