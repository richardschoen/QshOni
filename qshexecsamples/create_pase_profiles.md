## Create PASE profiles for IBM i Open Source Packages
If you have trouble findin default PASE packages located in /QOpenSys/pkgs/bin, you can create the folloiwing files in your users HOME directory. 

### From a 5250 session, run strqsh to get a command line
Run each of the following commands from the command line
```
echo PATH=/QOpenSys/pkgs/bin:$PATH > ~/.profile
```
```
echo export PATH=/QOpenSys/pkgs/bin:$PATH > ~/.bashrc
```
```
echo export PATH=/QOpenSys/pkgs/bin:$PATH > ~/.bash_profile
```
