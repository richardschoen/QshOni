# PFGREP Command Usage Samples
THe PFGREP command runs the pfgrep PASE utility under the covers using the QSHBASH command from QShell on i.  
  
Simon Hutchinsone Grep Article   
https://www.rpgpgm.com/2023/12/using-qshell-to-search-source-members.html
  
#### Example to scan QCLSRC in library QGPL for the word: sbs
PFGREP CMDARGS('-i -n "sbs" /QSYS.LIB/QGPL.LIB/QCLSRC.FILE/*.MBR') DSPSTDOUT(*YES)                                         

#### Example to scan all Q* files in library QGPL for the word: sbs
PFGREP CMDARGS('-i -n "sbs" /QSYS.LIB/QGPL.LIB/Q*.FILE/*.MBR') DSPSTDOUT(*YES)                                         
