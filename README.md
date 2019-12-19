# Domoticz-Google-Assistant Installer

This bash script installs the [Domoticz-Google-Assistant](https://github.com/DewGew/Domoticz-Google-Assistant) in a virtual enviroment.

Just open a terminal window and execute this command. Thats it!
```bash
bash <(curl -s https://raw.githubusercontent.com/DewGew/dzga-installer/master/install.sh)
```
Start/stop Domoticz-Google-Assistant server:
```bash
sudo systemctl start dzga
sudo systemctl stop dzga
```
Check if service is running:
```bash
sudo systemctl status dzga
```
To update run installer again:
```bash
bash <(curl -s https://raw.githubusercontent.com/DewGew/dzga-installer/master/install.sh)
```
To run manually:
```
cd /home/${USER}/
sudo systemctl stop dzga #If service is running
source Domoticz-Google-Assistant/env/bin/activate
python3 Domoticz-Google-Assistant
```
Uninstall:
```bash
cd /home/${USER/
sudo systemctl stop dzga
sudo systemctl disable dzga
sudo rm /etc/systemd/system/dzga.service
sudo rm -r /home/${USER/Domoticz-Google-Assistant
```

[Domoticz-Google-Assistant wiki](https://github.com/DewGew/Domoticz-Google-Assistant/wiki)
