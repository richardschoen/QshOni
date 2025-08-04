# Using pfgrep utility to search IFS files and Physical FIles such as Source Files 
The Seiden Group pfgrep utility is useful for searching IFS and source physical files such as source members.

## Sample Commands

### Search for value in files within IFS directory
The following sample command uses the pfgrep utility to search for a value of: 127.0.0.1 in IFS folder structure /home/user and also recurses the subdirectories.   
```
QSHONI/QSHBASH CMDLINE('/qopensys/pkgs/bin/pfgrep -i -r 127.0.0.1 /home/user')            
               PRTSTDOUT(*YES) PRTSPLF(PFGREP)                                          
```

## Links

### pfgrep GitHub page   
https://github.com/SeidenGroup/pfgrep   

### Physical File Grep (PFGREP): Fast IBM i Source Code Search   
https://www.seidengroup.com/2025/03/25/physical-file-grep-pfgrep-fast-ibm-i-source-code-search 

