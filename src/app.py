import os
import time
import json
import flask
import pymongo
import requests
from db import *
from flask import request, render_template, url_for

current_dir = os.path.dirname(os.path.abspath(__file__))

@app.route("/user", methods=["POST"])
def user():
    response = {"success": False}
    if flask.request.method == "POST":
        response["success"] = True
    return flask.jsonify(response)

def main():
    app.run(host="0.0.0.0", port=80)

if __name__ == "__main__":
    main()
