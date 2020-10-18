#!/bin/bash
sudo yum update -y

# Install Python3 and git
sudo yum install python36 python36-pip git -y

# Clone and install the app
git clone https://github.com/edugdias/oowlish.git
cd oowlish
python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt

# Configure app startup script
sudo cp ./bin/oowlish /etc/init.d
sudo chmod 755 /etc/init.d/oowlish

# Start the Oowlish app
sudo /etc/init.d/oowlish start
