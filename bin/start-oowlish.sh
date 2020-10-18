#!/bin/bash
cd /home/ec2-user/oowlish
python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
export APP_SECRET_TOKEN=SomeSecretToken
python3 /home/ec2-user/oowlish/app.py &
