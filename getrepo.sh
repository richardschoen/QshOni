#!/QOpenSys/usr/bin/qsh
#----------------------------------------------------------------
# Script name: getrepo.sh
# Author: Richard Schoen
# Purpose: Get QSHONI repo
#----------------------------------------------------------------
INSTALLTEMP="/tmp/qshoniinst"
REPONAME="https://github.com/richardschoen/QshOni.git"
SRCLIB="QSHONI"
SRCLIBTEXT="QShell on IBM i"
SRCFILE="SOURCE"
installpath="/tmp/qshoniinst"

# Create temp download location
mkdir ${INSTALLTEMP}
cd /${INSTALLTEMP}
# Clone the repo via git
git -c http.sslVerify=false clone --recurse-submodules ${REPONAME}
# Change to download directory and call build.sh to create library
cd ${INSTALLTEMP}
#build.sh
