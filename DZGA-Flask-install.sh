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

FOLDER="DZGA-Flask"

cd /home/${USER}/
clear
if [ ! -d ${FOLDER} ]; then
    # Check if Git is needed
    if [ ! -x "$(command -v git)" ]; then
        if [ -x "$(command -v apt)" ]; then
            sudo apt-get install git -y
        fi
    fi
    echo "*--------------------**---------------------*"
    echo "Install DZGA-Flask"
    echo "---------------------------------------------"
    echo "*Note : Dzga-Flask is free"
    echo "*for personal use."
    echo "---------------------------------------------"
    echo "Install the DZGA-Flask?"
    echo "(y)es or (N)o? Default : No"
    read theBranchChoice
    if [ "$theBranchChoice" = "Y" ] || [ "$theBranchChoice" = "y" ]; then
        echo "Installing DZGA-Flask"
        theBranch='development'
    else
        echo "Abort install"
        exit 1
    fi
    # Download from Git repository
    gitURL="https://github.com/DewGew/DZGA-Flask"
    git clone $gitURL.git -b $theBranch ${FOLDER}
    # Installing dependencies
    sudo chmod +x ~/${FOLDER}/scripts/install.sh
    sudo ./${FOLDER}/scripts/install.sh
    # Installing service
    sudo chmod +x ~/${FOLDER}/scripts/service-installer.sh
    sudo ./${FOLDER}/scripts/service-installer.sh
    sudo systemctl daemon-reload
    sudo systemctl enable dzga-flask.service
    echo ""
    echo " Starting DZGA-Flask..."
    echo ""
    sudo systemctl start dzga-flask.service
    cd ${FOLDER}
    sleep 2
else
    echo "!-----------------------------------!"
    echo "DZGA-Flask is already installed."
    echo ""
    cd ${FOLDER}
    echo ""
    echo " Check github for update..."
    echo ""
    git reset --hard
    git pull
    echo ""
    sudo systemctl restart dzga-flask.service
fi
echo "  Login to DZGA-Flask Server UI at: http://ip.address:8181"
echo "  Default username is admin and default password is smarthome"
echo ""
echo "*-----------------------------------*"
