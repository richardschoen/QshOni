#!/QOpenSys/pkgs/bin/python3
#------------------------------------------------
# Script name: pygetcurrentip.py
#
# Description: 
# This script will get your current public IP address.
#
# Parameters
# None
#------------------------------------------------
import requests
import json
import argparse
import sys
from sys import platform
import os
import re
import time
import traceback
from datetime import datetime, timezone 

def get():
    endpoint = 'https://ipinfo.io/json'
    response = requests.get(endpoint, verify = True)

    if response.status_code != 200:
        return 'Status:', response.status_code, 'Problem with the request. Exiting.'
        exit()

    data = response.json()

    return data['ip']

# Initialize or set variables
exitcode=0 #Init exitcode
exitmessage=''

#Output messages to STDOUT for logging
print("-------------------------------------------------------------------------------")
print("Get current Internet IP address")
print("Start of Main Processing - " + time.strftime("%H:%M:%S"))
print("OS:" + platform)

#------------------------------------------------
# Main script logic
#------------------------------------------------
try: # Try to perform main logic

  #get my ip
  my_ip = get()

  #print my ip return value
  print(f'RETURNIP:{my_ip}')
  
  # Output return parameter values to STDOUT log info
  # Return info keywords start with: RETURNPARMxx:
  print(f'RETURNPARM01:{my_ip}')

  #set reutn values
  exitmessage=my_ip
  exitcode=0

#------------------------------------------------
# Handle Exceptions
#------------------------------------------------
except Exception as ex: # Catch and handle exceptions
   exitcode=99 # set return code for stdout
   exitmessage=str(ex) # set exit message for stdout
   print('Traceback Info') # output traceback info for stdout
   traceback.print_exc()        

#------------------------------------------------
# Always perform final processing
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
