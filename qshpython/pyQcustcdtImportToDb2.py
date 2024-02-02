#!/QOpenSys/pkgs/bin/python3
#------------------------------------------------
# Script name: pyQcustcdtImportToDb2.py
#
# Description: 
# This script will read the selected CSV file and 
# insert the records to your specified version 
# of the QIWS/QCUSTCDT file. 
# Before using make a copy of QIWS/QCUSTCDT to QIWS/QCUSTCDT2
#
# Parameters
# None
#------------------------------------------------

import sys
from sys import platform
import os
import re
import time
import traceback
import csv
import pyodbc
        
#------------------------------------------------
# Script initialization
#------------------------------------------------

# Initialize or set variables
exitcode=0 #Init exitcode
exitmessage=''
connstring="DSN=*LOCAL;CommitMode=0" # Local IBMi ODBC DSN as current user
reccounter=0

# TODO Set selected work variables  
csv_filename="" # IFS Location to CSV File Ex: /tmp/qcustcdt.csv
ibmi_library="QIWS" # This library is on every IBMi system 
ibmi_file="QCUSTCDT2" # Copy QIWS/QCUSTCDT to QIWS/QCUSTCDT2 so we don't wreck QIWS/QCUSTCDT
                      # by adding too much data to it

# Output messages to STDOUT for logging
print("-------------------------------------------------------------------------------")
print("Read CSV File and Write to DB2 Table")
print("Start of Main Processing - " + time.strftime("%H:%M:%S"))
print("OS:" + platform)

def insert_qcustcdt(cursor,library,table,cusnum,lstnam,init,street,city,state,zipcod,cdtlmt,chgcod,baldue,cdtdue):
    #----------------------------------------------------------
    # Function: insert_qcustcdt
    # Desc: Insert new record into Customer Master
    # :cursor - Open ODBC cursor
    # :library - IBMi library name for table  
    # :table - IBMi table name
    # :param field names: Each individual field name needed
    # :return: Result value from query. 1=Successful insert,  Any other value is an error. -2=Exception
    #----------------------------------------------------------
    try:
       # Create the SQL statement 
       sql = """insert into %s.%s (cusnum,lstnam,init,street,city,state,zipcod,cdtlmt,chgcod,baldue,cdtdue) VALUES(%s,'%s','%s','%s','%s','%s',%s,%s,%s,%s,%s)""" % (library,table,cusnum,lstnam,init,street,city,state,zipcod,cdtlmt,chgcod,baldue,cdtdue)

       # Insert the record
       rtnexecute=cursor.execute(sql)

       # Return rowcount affected
       return cursor.rowcount

    except Exception as e:
        print(e) # Print error to stdout   
        return -2 # return -2 on error 

#------------------------------------------------
# Main script logic
#------------------------------------------------
try: # Try to perform main logic

      # Open ODBC connection       
      conn = pyodbc.connect(connstring)
      
      # Get cursor for open connection
      c = conn.cursor()

      # Bail if no CSV file specified
      if (csv_filename.strip()==""): 
        raise Exception(f"No CSV file specified.")
      
      # Open CSV file for reading 
      print(f"Opening CSV File {csv_filename}") 
      with open(csv_filename, "r") as csv_file:

        # Get the CSV reader     
        csv_reader = csv.reader(csv_file)
        next(csv_reader)  #  skip header row

        # Read in each CSV record and insert to IBM i table 
        print(f"Iterating CSV Records")
        for row in csv_reader:
        
           # Increment current record counter 
           reccounter += 1 
        
           # Print row info for logging. Just an example to log cust number and rec#. You can log what you want. 
           print(f"Processing record: {reccounter} - Cusnum:{row[0]}")
           
           # Pass the fields from the CSV in the correct ordinal position to the insert_qcustcdt function. 
           # In the QCUSTCDT.CSV file, field order matches the physical file.
           rtninsert=insert_qcustcdt(c,ibmi_library,ibmi_file,row[0],row[1],row[2],row[3],row[4],row[5],row[6],row[7],row[8],row[9],row[10])

           # Bail out if errors
           if (rtninsert != 1):
              raise Exception(f"Error occurred on insert to file: {ibmi_library}/{ibmi_file}")

        # Close cursor and database connection. We're done 
        c.close()
        conn.close()

        # Set success info
        exitcode=0
        exitmessage=f"Completed successfully. {reccounter} records inserted."
 
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
