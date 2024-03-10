#!/QOpenSys/pkgs/bin/python3
#------------------------------------------------
# Script name: cmdlineparmsample1.py
#
# Description: 
# This script is a good example of adding flexible  
# command line parameter processing and parm validation
# without caring which position a parm is passed in.
#
# Parameters:
# --inputfile - Input file name
# Valid formats: --inputfile=filename.txt  or 
#                --inputfile filename.txt     
#                --inputfile="filename.txt"
#                --inputfile "filename.txt"
#
# --outputfile - Output file name
# Valid formats: --outputfile=filename.txt  or 
#                --outputfile filename.txt     
#                --outputfile="filename.txt"
#                --outputfile "filename.txt"
#
# --replace - Replace existing=True-replace, False-Do not replace
# Valid formats: --replace=true  or 
#                --replace true     
#                --replace="filename.txt"
#                --replace "filename.txt"
#
# Pip packages needed:
# None - argparse is a standard module.
#
# Web reference links:
# http://zetcode.com/python/argparse/
# https://stackoverflow.com/questions/5943249/python-argparse-and-controlling-overriding-the-exit-status-code
# https://www.techbeamers.com/use-try-except-python/
# argument parse exceptions
# https://stackoverflow.com/questions/8107713/using-argparse-argumenterror-in-python
#------------------------------------------------

import argparse
import sys
from sys import platform
import os
import re
import time
import traceback
from pathlib import Path
from datetime import date
import datetime

#------------------------------------------------
# Script initialization
#------------------------------------------------

# Initialize or set variables
appname="Command Line Parser Sample"
exitcode=0 #Init exitcode
exitmessage=''
dashes="-------------------------------------------------------------------"
today=date.today()
curr_date = datetime.datetime.now()
parmsexpected=6;
datestamp=time.strftime("%Y%m%d")
timestamp=time.strftime("%H%M%S")
datetime2=time.strftime("%d%H%M%S")
datetime3=time.strftime("%m/%d/%y-%H%M%S")

# Create parm variables
inputfile=""
outputfile=""
replace=""

#------------------------------------------------
# Define some useful functions
#------------------------------------------------

def str2bool(strval):
    #-------------------------------------------------------
    # Function: str2bool
    # Desc: Constructor
    # :strval: String value for true or false
    # :return: Return True if string value is" yes, true, t or 1
    #-------------------------------------------------------
    return strval.lower() in ("yes", "true", "t", "1")

def trim(strval):
    #-------------------------------------------------------
    # Function: trim
    # Desc: Alternate name for strip
    # :strval: String value to trim. 
    # :return: Trimmed value
    #-------------------------------------------------------
    return strval.strip()

def rtrim(strval):
    #-------------------------------------------------------
    # Function: rtrim
    # Desc: Alternate name for rstrip
    # :strval: String value to trim. 
    # :return: Trimmed value
    #-------------------------------------------------------
    return strval.rstrip()

def ltrim(strval):
    #-------------------------------------------------------
    # Function: ltrim
    # Desc: Alternate name for lstrip
    # :strval: String value to ltrim. 
    # :return: Trimmed value
    #-------------------------------------------------------
    return strval.lstrip()

#------------------------------------------------
# Main script logic
#------------------------------------------------

# Output messages to STDOUT for logging
print(dashes)
print(appname)
print("Start of Main Processing - " + time.strftime("%H:%M:%S"))
print("OS:" + platform)

try: # Try to perform main logic      


   # Set up the command line argument parsing.
   # If the parse_args function fails, the program will
   # exit with an error 2. In Python 3.9, there is 
   # an argument to prevent an auto-exit
   # Each argument has a long and short version
   parser = argparse.ArgumentParser()
   parser.add_argument('-i','--inputfile', required=True,help="Input filename")
   parser.add_argument('-o','--outputfile', required=True,help="Output file name")
   #parser.add_argument('-r','--replace',help="True=Replace output file,False=Do not replace output file. Default=False")
   parser.add_argument('-r','--replace',default="False",required=False,help="True=Replace output file,False=Do not replace output file. Default=False")
   # Parse the command line arguments 
   args = parser.parse_args()

   # Pull arguments into variables so they are meaningful
   inputfile=args.inputfile.upper().strip()
   outputfile=args.outputfile.strip()
   # If replace parm passed, use passed value instead of default
   replace=str2bool(args.replace.strip())
 
   # Argument parsing is done. Let's do some work
   # In our case we will just PRINT the variables 
   # to the console. Good for debugging or logging
   print(dashes)
   print("Parameters:")
   print(f"Script file: {sys.argv[0]}")
   print(f"Input file: {inputfile}")
   print(f"Output file: {outputfile}")
   print(f"Replace file: {replace}")   
      
   # Set success info
   exitcode=0
   exitmessage=f"Parameter sample ran successfully."

#------------------------------------------------
# Handle Exceptions
#------------------------------------------------
# System Exit occurred. Most likely from argument parser
except SystemExit as ex:
     #print("Command line argument error.")
     #######print("Command line arguments triggered script exit.")
     exitcode=ex.code # set return code for stdout
     exitmessage=str(ex) # set exit message for stdout
     ###Enable the following for detailed trace
     ###print('Traceback Info') # output traceback info for stdout
     ###traceback.print_exc()      

except argparse.ArgumentError as exc:
     exitcode=99 # set return code for stdout
     exitmessage=str(exc) # set exit message for stdout
     print('Traceback Info') # output traceback info for stdout
     traceback.print_exc()      
     sys.exit(99)

except Exception as ex: # Catch and handle exceptions
     exitcode=99 # set return code for stdout
     exitmessage=str(ex) # set exit message for stdout
     print('Traceback Info') # output traceback info for stdout
     traceback.print_exc()        
     sys.exit(99)
#------------------------------------------------
# Always perform final processing
#------------------------------------------------
finally: # Final processing
     # Do any final code and exit now
     # We log as much relevent info to STDOUT as needed
     print("")
     print(dashes)
     print('ExitCode:' + str(exitcode))
     print('ExitMessage:' + exitmessage)
     print("End of Main Processing - " + time.strftime("%H:%M:%S"))
     print(dashes)
