#!/QOpenSys/pkgs/bin/python3
#------------------------------------------------
# Script name: pycallparm1.py
#
# Description: 
# This script will do some work and return selected values as 
# parameters in the STDOUT stream. Then the parms are returned 
# directly to the calling CL program if used with the QSHPYCALL or 
# the QSHCALL commands. 
#
# Parameters
# --parm1/-parm1=Sample parameter 1. Pass any test in and comes back as return parm 1 ni this example.
#------------------------------------------------
# Imports
#------------------------------------------------
import sys
from sys import platform
import os
import time
import traceback
import datetime as dt
from string import Template 
import argparse

#------------------------------------------------
# Script initialization
#------------------------------------------------

# Initialize or set variables
appname="Call Parm Sample 1"
exitcode=0 #Init exitcode
exitmessage='' #Init the exit message
returnval01=""
returnval02=""
returnval03=""
returnval04=""
returnval05=""
returnval06=""
returnval07=""
returnval08=""
returnval09=""
returnval10=""

#Output messages to STDOUT for logging
print("-------------------------------------------------------------------------------")
print(appname)
print("Start of Main Processing - " + time.strftime("%H:%M:%S"))
print("OS:" + platform)

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
try: # Try to perform main logic
   
   # Set parameter work variables from command line args
   parmscriptname = sys.argv[0]    #Script name

   # Set up the command line argument parsing.
   # If the parse_args function fails, the program will
   # exit with an error 2. In Python 3.9, there is 
   # an argument to prevent an auto-exit
   # Each argument has a long and short version
   parser = argparse.ArgumentParser()
   parser.add_argument('-parm1','--parm1',default="Parm1 Not Passed", required=False,help="test parm value")
   
   # Parse the command line arguments 
   args = parser.parse_args()

   # Output parameter variables to STDOUT log
   print("Parameters:")
   print(f'Parm1:{args.parm1.strip()}')
   
   # TODO - Do some work here.........
   # 1.) Read database, calc some values, etc....
   # 2.) Then set return parms into returnval01-returnval10
   # This tecnique can be used when you want to return parms directly 
   # to a CL or RPG calling program if called by QSHPYCALL or QSHCALL
   # CL commands which can only be embedded in a CL or RPG program.  
   
   # Set and write return parameter values to STDOUT
   returnval01=args.parm1.strip()  # Return value passed in parm 1 
   # Return a sample 255 char value
   returnval02="123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456710012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345672001234567890123456789012345678901234567890123456785012345"  
   returnval03="Return 3"  # Return any text value you want 
   returnval04="Return 4"  # Return any text value you want 
   returnval05="Return 5"  # Return any text value you want 
   returnval06="Return 6"  # Return any text value you want 
   returnval07="Return 7"  # Return any text value you want 
   returnval08="Return 8"  # Return any text value you want 
   returnval09="Return 9"  # Return any text value you want 
   returnval10="Return 10" # Return any text value you want 
  
   # Output return parameter values to STDOUT log info
   # Return info keywords start with: RETURNPARMxx:
   print(f'RETURNPARM01:{returnval01}')
   print(f'RETURNPARM02:{returnval02}')
   print(f'RETURNPARM03:{returnval03}')
   print(f'RETURNPARM04:{returnval04}')
   print(f'RETURNPARM05:{returnval05}')
   print(f'RETURNPARM06:{returnval06}')
   print(f'RETURNPARM07:{returnval07}')
   print(f'RETURNPARM08:{returnval08}')
   print(f'RETURNPARM09:{returnval09}')
   print(f'RETURNPARM10:{returnval10}')

   # Set success info
   exitcode=0
   exitmessage=appname + " was successful."

#------------------------------------------------
# Handle Exceptions
#------------------------------------------------
# System Exit occurred. Most likely from argument parser
except SystemExit as ex:
     print("Command line argument error.")
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
# Always perform final processing. Output exit message and exit code
#------------------------------------------------
finally: # Final processing
    # Do any final code and exit now
    # We log as much relevent info to STDOUT as needed
    print('ExitCode:' + str(exitcode))
    print('ExitMessage:' + exitmessage)
    print("End of Main Processing - " + time.strftime("%H:%M:%S"))
    print("-------------------------------------------------------------------------------")
    
    # Exit the script now
    sys.exit(exitcode) 
