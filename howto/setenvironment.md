# How to set an environment variable prior to calling a script using QSHEXEC or QSHBASH
It might be handy to be able to know if a particular job is calling a script such as a PHP, Python or other Bash script. 

Here's a couple of options for setting environment variables for your scripts to pick up. 

Add the environment variable from the IBM i CL or RPG job using the ADDENVVAR CL command or some other tool.   

This example adds an env variable named CALLEDBY and then lists it for display by calling env from the PASE job.
```
ADDENVVAR ENVVAR(CALLEDBY) VALUE(QSHONI)

QSHONI/QSHBASH CMDLINE(env) DSPSTDOUT(*YES)
```

This example adds an env variable named CALLEDBY by calling the export command on the QSH/PASE command line and then lists it for display by calling env from the PASE job.  
```
QSHONI/QSHBASH CMDLINE('export CALLEDBY=QSHONI;env') DSPSTDOUT(*YES) 
```
