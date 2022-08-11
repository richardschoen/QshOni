# QSHONI sample commands

This section contains useful sample commands that utilize the QSHONI library commands. 

These commands are not shipped as part of the core QSHONI library code.

# Using the PGDUMP CL command to back up a Postgres database to an IFS output file

Log in as the ```POSTGRES``` user profile on an IBM i 5250 session or submit the command as the ```POSTGRES``` user or other authorized Postgres database user.

The following example calls the Postgres pg_dump command internally to back up the selected database. After the backup the tar command is used to validate that the backup output tar file is not corrupted.

```
      PGDUMP DATABASE(gitbucket) 
      OUTPUTFILE('/tmp/gitbucketbackup-20220811.tar')    
      FORMAT('t')
      REPLACE(*NO)
```

# PGDUMP command parms

**Overview** - This CL command can be used to run a Postgres pg_dump command to back up the selected Postgres database to a tar file.

**DATABASE** - Enter a valid existing Postgres database name. 

**OUTPUTFILE** - IFS file for the tar file that gets created from the pg_dump command.

**FORMAT** - The output format for the pg_dump command. ***Default - 't' to output in tar format. ***

**REPLACE** - IFS replace existing output file option. *YES = replace IFS file. *NO = Fail if file already exists. ***Default = *NO ***


# Using the PGRESTORE CL command to restore a Postgres database from an IFS output file

The Postgres database must already exist and can be replaced. 

Log in as the ```POSTGRES``` user profile on an IBM i 5250 session or submit the command as the ```POSTGRES``` user or other authorized Postgres database user.

The following example calls the Postgres pg_restore command internally to restore the selected database fromt he selected IFS tar file.

```
          PGRESTORE DATABASE(gitbucket)   
          INPUTFILE('/tmp/gitbucketbackup-20220811.tar')    
          OPTIONS('-c')         
          PROMPT(*NO)
```

# PGRESTORE command parms

**Overview** - This CL command can be used to run a Postgres pg_restore command to restore a Postgres database from an IFS output file.

**DATABASE** - Enter a valid existing Postgres database name. (If restoring to a new database, the database must be created via psql prior to restoring the database.)

**INPUTFILE** - IFS file for the tar file that gets restored from via the pg_restore command.

**OPTIONS** - Restore options. Ex: ```-c``` will clear the database of all objects before restoring. Only use the ```-c``` option on a database that already contains object. Otherwise the restore may fail on the first try. However a second restore try may work. 

**PROMPT** - On an interactive 5250 job prompt the QSHBASH command so the user can see what the QSH/PASE restore command line looks like. This might be used when testing a new call. *YES = Prompt for QSHBASH. *NO = No prompting for QSHBASH. ***Default = *NO ***
