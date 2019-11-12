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

cd /home/${USER}/
clear
if [ ! -d "Domoticz-Google-Assistant" ]; then
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
    echo "Install the Development branch?"
    echo "(y)es or (N)o? Default : No"
    read theBranchChoice
    if [ "$theBranchChoice" = "Y" ] || [ "$theBranchChoice" = "y" ]; then
        echo "Getting the Development Branch"
        theBranch='beta'
    else
        echo "Getting the Master Branch"
        theBranch='master'
    fi
    # Download from Git repository
    gitURL="https://github.com/DewGew/Domoticz-Google-Assistant"
    git clone $gitURL.git -b $theBranch Domoticz-Google-Assistant
    # Installing dependencies
    sudo chmod +x ~/Domoticz-Google-Assistant/scripts/install.sh
    sudo ./Domoticz-Google-Assistant/scripts/install.sh
    # Installing service
    sudo chmod +x ~/Domoticz-Google-Assistant/scripts/service-installer.sh
    sudo ./Domoticz-Google-Assistant/scripts/service-installer.sh
    sudo systemctl daemon-reload
    sudo systemctl enable dzga.service
    echo ""
    echo " Starting Domoticz Google Assistant..."
    echo ""
    sudo systemctl start dzga.service
    cd Domoticz-Google-Assistant
    sleep 2
else
    echo "!-----------------------------------!"
    echo "Domoticz-Google-Assistant already downloaded."
    echo ""
    echo " Check for update..."
    echo ""
    cd Domoticz-Google-Assistant
    git reset --hard
    git pull
    echo ""
    sudo systemctl restart dzga.service
fi
# start the installer in the main app (or start shinobi if already installed)
_IP="$( ip route get 8.8.8.8 | awk 'NR==1 {print $NF}' )"
_PORT="$( grep -A0 'port_number:' config.yaml | tail -n1 | awk '{ print $2}')"
echo "  Login to Domoticz Google Assistant Server UI at: http://$_IP:$_PORT/settings"
echo "  Default username and password id \'admin'\"
echo ""
echo "*-----------------------------------*"
