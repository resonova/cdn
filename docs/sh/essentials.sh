#! /bin/bash
################################################################################
#  INSTALL LINUX ESSENTIALS  #
##############################
#
#   install-linux-essentials.sh - (Version 1.0.7)
#   See changes in the "updates log" at the end of this file
#
# ---------------------------# ATTRIBUTION #------------------------------------
#
#   AUTHOR:     h8rt3rmin8r
#   DATE:       20180416
#   EMAIL:      161803398@email.tg
#   PGP:        https://h8rt3rmin8r.com
#   SOURCE-1:	https://pastebin.com/raw/Ls5JuEGH
#   SOURCE-2:   https://h8rt3rmin8r.com/sh/install-linux-essentials.sh
#
# ---------------------------# SOFTWARE LICENSE #-------------------------------
#
#   Copyright 2018 ResoNova International Consulting, LLC
# 
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at:
# 
#       http://www.apache.org/licenses/LICENSE-2.0
# 
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
# ---------------------------# DESCRIPTION #------------------------------------
#
#   This script is intended to be run inside a fresh Ubuntu installation. The
#   script will download and install all top recommended packages and programs
#   not already bundled with the core Ubuntu OS. Additionally, this script will
#   download and make available several useful shell scripts that can be used
#   to facilitate several common features and functions.
#
#   This script is ready to be used in a headless server out of the box. To 
#   enable the installation of graphical utilities and software, simply 
#   uncomment the items in the "graphical software" section as desired.
#
# ---------------------------# INSTRUCTIONS #-----------------------------------
#
#   Enable execution of this script by navigating to the directory in which this
#   script is located and run the following command:
#
#       sudo chmod +x install-linux-essentials.sh
#
#   Now you must become the root user in order to perform the actions contained
#   in this script. Do so with the following command:
#
#       sudo -s
#
#   You may be asked to type in your password after issuing the command above.
#   Now you just need to execute this script with the following command:
#
#       ./install-linux-essentials.sh
#
# ---------------------------# OVERVIEW #---------------------------------------
#
# [ PHASE 1 ] - INITIAL SETUP
#
#   Initial setup of the environment in preparation for upcoming installations
#
# [ PHASE 2 ] - PACKAGES INSTALLED
#
#   Installation of all non-graphical software packages
#
#   curl        (Command line URL tool)
#   wget        (The non-interactive network downloader)
#   bc          (An arbitrary precision calculator language)
#   wscat       (Communicate over websocket)
#   gcsfuse     (Google Cloud Storage utility)
#   apache2     (Web Server)
#   jq          (JSON Utility)
#   htop        (Interactive process viewer)
#   html2text   (HTML to text conversion tool)
#   dos2unix    (DOS/Mac to Unix text file format converter)
#   xmlstarlet  (Command line XML/XSLT toolkit)
#   nmap        (Network mapping tool)
#   arp-scan    (The classic ARP scanner)
#   lynx        (Command line web browser)
#   git         (Repository management utility)
#   unzip       (The unzip tool for extracting zipped directories)
#   tree        (Directory tree viewer)
#   virtualenv  (Python virtual environment creator and management tool)
#   gdebi       (Simple tool to install deb files)
#   gcloud      (Google Cloud SDK) #Uncomment to enable installation!
#
# [ PHASE 3 ] - OPTIONAL GRAPHICAL SOFTWARE
#
#   Installation of graphical software packages
#
#   code        (Visual Studio Code - an essential IDE created by Microsoft)
#
# [ PHASE 4 ] - SHELL SCRIPTS DOWNLOADED
#
#   Downloading and enabling additional bash scripts
#
#   fix-gcloud-key  (Fix expired Google Cloud Shell expired keys error)
#   checkip         (Check your system IP address)
#   btcusd          (Check the current bitcoin/USD exchange rate)
#   nova            (Calculate floating point arithmetic in the terminal)
#
################################################################################
#  FUNCTIONS  #
###############

# [ PHASE 1 ] ------------------------------------------------------------------
#
#   Initial setup of the environment in preparation for upcoming installations
#
#-------------------------------------------------------------------------------

# DATE-TIME VARIABLE
DT="`date '+%Y%m%d-%H%M%S'`"

echo "[ ${0} ]: BEGINNING PROCESSES..."

# VERIFY ROOT ACCESS
uid=`id -u $USERNAME`

if [ "$uid" == "0" ]
    then
        echo "[ ${0} ]: User is root"
    else
        echo "[ ${0} ]: You need to have root access. Run with sudo"
    exit 1
fi

# Move to home directory and create core installation directories
cd ${HOME}
mkdir -p .software/{install-linux-essentials,fix-gcloud-key,checkip,btcusd,nova}
cd .software/install-linux-essentials

# Create the install log file and assign the appropriate variable
touch install-linux-essentials.log
LOG="~/.software/install-linux-essentials/install-linux-essentials.log"
echo ${DT}" -- Beginning processes as root user" > ${LOG}
echo ${DT}" -- Updating package list and installing initial system updates" >> ${LOG}
echo "[ ${0} ]: Updating package list and installing initial system updates"

# Update the package list and install updates
apt-get update
apt-get -y upgrade
apt-get -y dist-upgrade

# [ PHASE 2 ] ------------------------------------------------------------------
#
#   Installation of all non-graphical software packages
#
#-------------------------------------------------------------------------------

echo ${DT}" -- Installing non-graphical software packages..." >> ${LOG}
echo "[ ${0} ]: Installing non-graphical software packages..."

# INSTALL: CURL
echo "[ ${0} ]: Installing curl"
echo ${DT}" -- Installing curl" >> ${LOG}
sleep 0.5
apt-get install -y curl

# INSTALL: WGET
echo "[ ${0} ]: Installing wget"
echo ${DT}" -- Installing wget" >> ${LOG}
sleep 0.5
apt-get install -y wget

# INSTALL: BC
echo "[ ${0} ]: Installing bc"
echo ${DT}" -- Installing bc" >> ${LOG}
sleep 0.5
apt-get install -y bc

# INSTALL: WSCAT
echo "[ ${0} ]: Installing wscat"
echo ${DT}" -- Installing wscat" >> ${LOG}
sleep 0.5
apt install -y node-ws

# INSTALL: GOOGLE CLOUD STORAGE UTILITY (gcsfuse)
echo "[ ${0} ]: Installing gcsfuse"
echo ${DT}" -- Installing gcsfuse" >> ${LOG}
sleep 0.5
export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s`
echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get install -y gcsfuse

# INSTALL: APACHE2
echo "[ ${0} ]: Installing apache2"
echo ${DT}" -- Installing apache2" >> ${LOG}
sleep 0.5
apt-get install -y apache2

# INSTALL: JQ
echo "[ ${0} ]: Installing jq"
echo ${DT}" -- Installing jq" >> ${LOG}
sleep 0.5
apt-get install -y jq

# INSTALL: HTOP
echo "[ ${0} ]: Installing htop"
echo ${DT}" -- Installing htop" >> ${LOG}
sleep 0.5
apt-get install -y htop

# INSTALL: HTML2TEXT
echo "[ ${0} ]: Installing html2text"
echo ${DT}" -- Installing html2text" >> ${LOG}
sleep 0.5
apt-get install -y html2text

# INSTALL: DOS2UNIX
echo "[ ${0} ]: Installing dos2unix"
echo ${DT}" -- Installing dos2unix" >> ${LOG}
sleep 0.5
apt-get install -y dos2unix

# INSTALL: XMLSTARTLET
echo "[ ${0} ]: Installing xmlstarlet"
echo ${DT}" -- Installing xmlstarlet" >> ${LOG}
sleep 0.5
apt-get install -y xmlstarlet

# INSTALL: NMAP
echo "[ ${0} ]: Installing nmap"
echo ${DT}" -- Installing nmap" >> ${LOG}
sleep 0.5
apt-get install -y nmap

# INSTALL: ARP-SCAN
echo "[ ${0} ]: Installing arp-scan"
echo ${DT}" -- Installing arp-scan" >> ${LOG}
sleep 0.5
apt-get install -y arp-scan

# INSTALL: LYNX
echo "[ ${0} ]: Installing lynx"
echo ${DT}" -- Installing lynx" >> ${LOG}
sleep 0.5
apt-get install -y lynx

# INSTALL: GIT
echo "[ ${0} ]: Installing git"
echo ${DT}" -- Installing git" >> ${LOG}
sleep 0.5
apt-get install -y git

# INSTALL: UNZIP
echo "[ ${0} ]: Installing unzip"
echo ${DT}" -- Installing unzip" >> ${LOG}
sleep 0.5
apt-get install -y unzip

# INSTALL: TREE
echo "[ ${0} ]: Installing tree"
echo ${DT}" -- Installing tree" >> ${LOG}
sleep 0.5
apt-get install -y tree

# INSTALL: VIRTUALENV
echo "[ ${0} ]: Installing virtualenv"
echo ${DT}" -- Installing virtualenv" >> ${LOG}
sleep 0.5
apt-get install -y virtualenv

# INSTALL: GDEBI
echo "[ ${0} ]: Installing gdebi"
echo ${DT}" -- Installing gdebi" >> ${LOG}
sleep 0.5
apt-get install -y gdebi

# INSTALL: GOOGLE CLOUD SDK
# Uncomment the following 4 lines to enable installation
#echo "[ ${0} ]: Installing gcloud"
#echo ${DT}" -- Installing gcloud" >> ${LOG}
#sleep 0.5
#curl https://sdk.cloud.google.com | bash

# FINISH PHASE 2 BY UPDATING THE PACKAGE LIST
apt-get update

echo ${DT}" -- Non-graphical software has been installed successfully!" >> ${LOG}
echo "[ ${0} ]: Non-graphical software has been installed successfully!"

# [ PHASE 3 ] ------------------------------------------------------------------
#
#   Installation of graphical software packages
#   UNCOMMENT THE APPROPRIATE SECTIONS TO ENABLE INSTALL
#
#-------------------------------------------------------------------------------

# INSTALL: VISUAL STUDIO CODE
#curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
#sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
#sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
#apt-get update && apt-get install -y code

# [PHASE 4 ] -------------------------------------------------------------------
#
#   Downloading and enabling additional bash scripts
#
#-------------------------------------------------------------------------------

echo ${DT}" -- Downloading and enabling additional bash scripts..." >> ${LOG}
echo "[ ${0} ]: Downloading and enabling additional bash scripts..."

# CREATE AND ENABLE "fix-gcloud-key"
# Description: Repair outdated Google Cloud PGP keys when they expire
cd ~/.software/fix-gcloud-key
wget -q https://pastebin.com/raw/KEh8dfFk
touch fix-gcloud-key
mv KEh8dfFk fix-gcloud-key
chmod +x fix-gcloud-key && cp fix-gcloud-key /usr/local/bin/fix-gcloud-key
dos2unix -k -o /usr/local/bin/fix-gcloud-key

# CREATE AND ENABLE "checkip"
# Description: Check the local system's public-facing IP address
cd ~/.software/checkip
wget -q https://pastebin.com/raw/yhV0nTH4
touch checkip
mv yhV0nTH4 checkip
chmod +x checkip && cp checkip /usr/local/bin/checkip
dos2unix -k -o /usr/local/bin/checkip

# CREATE AND ENABLE "btcusd"
# Description: Check the current bitcoin/USD exchange rate
cd ~/.software/btcusd
wget -q https://pastebin.com/raw/wZTWNkhd
touch btcusd
mv wZTWNkhd btcusd
chmod +x btcusd && cp btcusd /usr/local/bin/btcusd
dos2unix -k -o /usr/local/bin/btcusd

# CREATE AND ENABLE "nova"
# Description: Calculate floating point arithmetic in the terminal
cd ~/.software/nova
wget -q https://pastebin.com/raw/61fHwRCC
touch install-nova.sh
mv 61fHwRCC install-nova.sh
chmod +x install-nova.sh
dos2unix -k -o install-nova.sh
sudo ./install-nova.sh

# Make a local copy of this install script
cd .software/install-linux-essentials
wget -q https://pastebin.com/raw/Ls5JuEGH
touch install-linux-essentials.sh
mv Ls5JuEGH install-linux-essentials.sh
chmod +x install-linux-essentials.sh
dos2unix -k -o install-linux-essentials.sh

echo ${DT}" -- Additional bash scripts have been installed successfully!" >> ${LOG}
echo "[ ${0} ]: Additional bash scripts have been installed successfully!"

echo ${DT}" -- ALL PROCESSES COMPLETE!" >> ${LOG}
echo "--------------------------------------------------------------------------" >> ${LOG}
echo "Read the logs at ${LOG}" >> ${LOG}
echo "Email questions to h8rt3rmin8r at 161803398@email.tg" >> ${LOG}
echo "New commands available:" >> ${LOG}
echo "--------------------------------------------------------------------------" >> ${LOG}
echo "'fix-gcloud-key'  (Repair outdated Google Cloud PGP keys when they expire)" >> ${LOG}
echo "'checkip'         (Check your system's public IP address)" >> ${LOG}
echo "'btcusd'          (Check the current bitcoin/USD exchange rate)" >> ${LOG}
echo "'nova'            (Calculate floating point arithmetic in the terminal)" >> ${LOG}
echo "--------------------------------------------------------------------------" >> ${LOG}
echo "exiting script..." >> ${LOG}

# EXIT ROOT USER AND RETURN TO HOME
cd ${HOME}
echo ""
echo "[ ${0} ]: ALL PROCESSES COMPLETE!"
echo "--------------------------------------------------------------------------"
echo "Read the logs at ~/.sh/install-linux-essentials/install-linux-essentials.log"
echo "Email questions to h8rt3rmin8r at 161803398@email.tg"
echo ""
echo "New commands available:"
echo "--------------------------------------------------------------------------"
echo "'fix-gcloud-key'  (Repair outdated Google Cloud PGP keys when they expire)"
echo "'checkip'         (Check your system's public IP address)"
echo "'btcusd'          (Check the current bitcoin/USD exchange rate)"
echo "'nova'            (Calculate floating point arithmetic in the terminal)"
echo "--------------------------------------------------------------------------"
echo ""

exit

################################################################################
#  UPDATES LOG  #
#################
#
# 20180416 ---- Script created (1.0.0)
# 20180416 ---- Conducted first run of the script; encountered errors with the
#               scripts installed to /bin
# 20180416 ---- Added 'dos2unix' (to fix errors); included execution of dos2unix
#               on the scripts installed to /bin to correct the errors (1.0.1)
# 20180417 ---- Changed install of binaries from /bin to /usr/local/bin (1.0.2)
# 20180417 ---- Added install: 'unzip' (1.0.3)
# 20180422 ---- Added 'wscat' to installation list (1.0.4)
# 20180508 ---- Added 'bc' to installation list (1.0.5)
# 20180530 ---- Added 'virtualenv' to installation list; added 'nova' to bash
#               script installations (1.0.6)
# 20180611 ---- Removed unused date variables; cleaned script by making use of
#               variables; moved core directory from .sh to .software (1.0.7)
#
################################################################################
                                                   #                           #
                                                   #  "think outside the box"  #
                                                   #                           #
                                                   #    ($) ¯\_(ツ)_/¯ (฿)     #
                                                   #                           #
                                                   #############################
