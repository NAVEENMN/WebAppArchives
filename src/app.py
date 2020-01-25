import os
import time
import json
import flask
import pymongo
import requests
from db import *
from flask import request, render_template, url_for

current_dir = os.path.dirname(os.path.abspath(__file__))
app = flask.Flask(__name__)

db = database()

@app.route("/medteam/findusers", methods=["POST"])
def med_find_users():
    response = {"success": False}
    if flask.request.method == "POST":
        payload = dict()
        query_key = request.form.get('query_key')
        filter_list = request.form.get('filter_list')
        #query = {'languages': {'$in': ['Tamil', 'English'] }}
        query = {query_key: {'$in': filter_list }}
        response = db.find_entry('Medteam', 'Accounts', query=query, all_entry=True)
    return flask.jsonify(response)

@app.route("/medteam/adduser", methods=["POST"])
def med_add_user():
    response = {"success": False}
    if flask.request.method == "POST":
        payload = dict()
        payload['user_id'] = request.form.get('user_id')
        payload['name'] = request.form.get('name')
        payload['location'] = request.form.get('location')
        payload['designation'] = request.form.get('designation')
        payload['languages'] = request.form.get('languages')
        payload['about_me'] = request.form.get('about_me')
        payload['specialities'] = request.form.get('specialities')
        response = db.add_entry('medteam', 'accounts', payload)
    return flask.jsonify(response)

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
