#!/bin/bash
sudo yum update -y

# Install Python3 and git
sudo yum install python36 python36-pip git -y

# Clone and install the app
git clone https://github.com/edugdias/oowlish.git

# Configure app startup script
sudo cp /home/ec2-user/oowlish/bin/oowlish /etc/init.d
sudo chmod 755 /etc/init.d/oowlish

# Start the Oowlish app
sudo /etc/init.d/oowlish start
