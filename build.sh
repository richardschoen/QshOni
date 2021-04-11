#!/QOpenSys/usr/bin/qsh
#----------------------------------------------------------------
# Script name: build.sh
# Author: Richard Schoen
# Purpose: Create QSHONI library, copies source members and compiles objects
#----------------------------------------------------------------
SRCLIB="QSHONI"
SRCLIBTEXT="QShell on IBM i"
SRCFILE="SOURCE"
dashes="---------------------------------------------------------------------------"

function cpy_member
{
# ----------------------------------------------------------------
# Copy source member and set source type
# ----------------------------------------------------------------
  SRCMEMBER=`echo "${CURFILE^^}" | cut -d'.' -f1`  # Parse PC file name prefix to member name
  SRCTYPE=`echo "${CURFILE^^}" | cut -d'.' -f2`    # Parse PC file name extenstion to souce type
  system -v "CPYFRMSTMF FROMSTMF('${PWD}/${CURFILE}') TOMBR('/QSYS.LIB/${SRCLIB}.LIB/${SRCFILE}.FILE/${SRCMEMBER}.MBR') MBROPT(*REPLACE)"
  system -v "CHGPFM FILE(${SRCLIB}/${SRCFILE}) MBR($SRCMEMBER) SRCTYPE(${SRCTYPE}) TEXT('${SRCTEXT}')" 
}

echo "$dashes"
echo "Starting Build of ${SRCLIBTEXT} library ${SRCLIB}"

# Create library, clear library and create source file 
system -v "CRTLIB ${SRCLIB} TYPE(*PROD) TEXT('${SRCLIBTEXT}')"
system -v "CLRLIB LIB(${SRCLIB})"
system -v "CRTSRCPF FILE(${SRCLIB}/${SRCFILE}) RCDLEN(120)"

# Copy all the source members and set source types
CURFILE="QSHBASH.CMD"
SRCTEXT="Run Bash Command via Qshell"
cpy_member

CURFILE="QSHBASHC.CLLE"              
SRCTEXT="Run Bash Command via Qshell"                            
cpy_member

CURFILE="QSHEXEC.CMD"                
SRCTEXT="Run Bash Command via Qshell"                          
cpy_member

CURFILE="QSHEXECC.CLLE"
SRCTEXT="Run QShell Command Line"
cpy_member

CURFILE="QSHLOGSCAC.CLP"
SRCTEXT="Scan Qshell Log File for Value"  
cpy_member

CURFILE="QSHLOGSCAN.CMD"
SRCTEXT="Scan Qshell Log File for Value"
cpy_member

CURFILE="QSHLOGSCAR.RPGLE"
SRCTEXT="Scan Qshell Log File for Value"
cpy_member

CURFILE="QSHPATH.CMD"
SRCTEXT="Set Open Source Package Path Environment Variables"
cpy_member

CURFILE="QSHPATHC.CLLE"
SRCTEXT="Set Open Source Package Path Environment Variables"
cpy_member

CURFILE="QSHSTDOUTR.RPGLE"
SRCTEXT="Read and parse stdout log"
cpy_member

CURFILE="QSHIFSCHKR.RPGLE"
SRCTEXT="Check for IFS File Existence"
cpy_member

CURFILE="QSHIFSCHKC.CLP"
SRCTEXT="Check for IFS File Existence"
cpy_member

CURFILE="QSHIFSCHK.CMD"
SRCTEXT="Check for IFS File Existence"
cpy_member

CURFILE="QSHPYRUN.CMD"
SRCTEXT="Run Python Script via Qshell"
cpy_member

CURFILE="QSHPYRUNC.CLLE"
SRCTEXT="Run Python Script via Qshell"
cpy_member

CURFILE="QSHDEMO01R.RPGLE"
SRCTEXT="Read Outfile STDOUTQSH and display via DSPLY cmd"
cpy_member

CURFILE="SRCBLDC.CLP"
SRCTEXT="Build cmds from QSHONI/SOURCE file"   
cpy_member

CURFILE="README.TXT"
SRCTEXT="Read Me Docs on Setup"
cpy_member

CURFILE="VERSION.TXT"
SRCTEXT="Version Notes"
cpy_member

# Create and run build program
system -q "CRTCLPGM PGM(${SRCLIB}/SRCBLDC) SRCFILE(${SRCLIB}/${SRCFILE})"
system -v "CALL PGM(${SRCLIB}/SRCBLDC)"

echo "${SRCLIBTEXT} library ${SRCLIB} was created and programs compiled."
echo "$dashes"
  
