import os

from flask import Flask
from flask_httpauth import HTTPTokenAuth

app = Flask(__name__)
auth = HTTPTokenAuth("Token")


@auth.verify_token
def verify_token(token):
    return token == os.getenv("APP_SECRET_TOKEN")

@app.route("/", methods=["GET"])
@auth.login_required
def home():
    return {
        "message": "DevOps test server is flying!!"
    }

app.run("0.0.0.0", port=8000)
