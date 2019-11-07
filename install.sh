#!/bin/bash
#
# Install systemd service files for running on startup.
#
# Copyright 2017 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (use sudo)" 1>&2
   exit 1
fi

cd /home/${USER}/
echo "Opening Install Location"
if [ ! -d "Domoticz-Google-Assistant" ]; then
    # Check if Git is needed
    if [ ! -x "$(command -v git)" ]; then
        if [ -x "$(command -v apt)" ]; then
            sudo apt update
            sudo apt install git -y
        fi
    fi
    # Check if wget is needed
    if [ ! -x "$(command -v wget)" ]; then
        if [ -x "$(command -v apt)" ]; then
            sudo apt install wget -y
        fi
    fi

    echo "*--------------------**---------------------*"
    echo "Install Domoticz-Google-Assistant"
    echo "---------------------------------------------"
    echo "*Note : Domoticz-Google-Assistant is free"
    echo "*for personal use."
    echo "---------------------------------------------"
    echo "Install the Development branch?"
    echo "(y)es or (N)o? Default : No"
    read theBranchChoice
    if [ "$theBranchChoice" = "Y" ] || [ "$theBranchChoice" = "y" ]; then
        echo "Getting the Development Branch"
        theBranch='dev'
    else
        echo "Getting the Master Branch"
        theBranch='master'
    fi
    # Download from Git repository
    gitURL="https://github.com/DewGew/Domoticz-Google-Assistant"
    sudo git clone $gitURL.git -b $theBranch Domoticz-Google-Assistant
    # Enter Domoticz-Google-Assistant folder
    cd Domoticz-Google-Assistant
else
    echo "!-----------------------------------!"
    echo "Domoticz-Google-Assistant already downloaded."
    cd Domoticz-Google-Assistant
fi
# start the installer in the main app (or start shinobi if already installed)
echo "*-----------------------------------*"
