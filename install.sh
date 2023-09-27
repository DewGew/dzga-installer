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

FOLDER="Domoticz-Google-Assistant"

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
    echo "Install Domoticz-Google-Assistant"
    echo "---------------------------------------------"
    echo "*Note : Domoticz-Google-Assistant is free"
    echo "*for personal use."
    echo "---------------------------------------------"
    echo "Getting the Master Branch"
    theBranch='master'
    # Download from Git repository
    gitURL="https://github.com/DewGew/Domoticz-Google-Assistant"
    git clone $gitURL.git -b $theBranch ${FOLDER}
    # Installing dependencies
    sudo chmod +x ~/${FOLDER}/scripts/install.sh
    sudo ./${FOLDER}/scripts/install.sh
    # Installing service
    sudo chmod +x ~/${FOLDER}/scripts/service-installer.sh
    sudo ./${FOLDER}/scripts/service-installer.sh
    sudo systemctl daemon-reload
    sudo systemctl enable dzga.service
    echo ""
    echo " Starting Domoticz Google Assistant..."
    echo ""
    sudo systemctl start dzga.service
    cd ${FOLDER}
    sleep 2
else
    echo "!-----------------------------------!"
    echo "Domoticz-Google-Assistant already installed."
    echo ""
    cd ${FOLDER}
    echo ""
    echo " Check github for update..."
    echo ""
    git reset --hard
    git pull
    echo ""
    sudo systemctl restart dzga.service
fi
echo "  Login to Domoticz Google Assistant Server UI at: http://ip.address:3030/settings"
echo "  Default username is admin and default password is admin"
echo "  or"
echo "  Goto Domoticz-Google-Assistant folder and Edit config.yaml and then"
echo "  restart dzga.server e.g 'sudo systemctl restart dzga' "
echo ""
echo "*-----------------------------------*"
