#!/QOpenSys/usr/bin/qsh
#----------------------------------------------------------------
# Script name: getrepo.sh
# Author: Richard Schoen
# Purpose: Get QSHONI repo and build the QSHONI library.
# **WARNING** - Make sure to back up existing QSHONI library instances 
#               before running build.sh
#               Existing QSHONI library will be cleared by build.sh
#----------------------------------------------------------------
INSTALLTEMP="/tmp"
INSTALLQSHONI="/tmp/QshOni"
REPONAME="https://github.com/richardschoen/QshOni.git"

# Create temp download IFS location
mkdir ${INSTALLTEMP}
cd /${INSTALLTEMP}
# Clone the repo via git to temporary download location
git -c http.sslVerify=false clone --recurse-submodules ${REPONAME}

# Change to IFS temp download directory for repo and call build.sh to create library
cd ${INSTALLQSHONI}
bash build.sh
# After installation you can manually delete the IFS directory /tmp/QshOni
