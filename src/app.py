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

def load_template_data(path):
    data = {}
    with open(path) as json_file:
        data = json.load(json_file)
    return data


@app.route("/app/problems", methods=["GET"])
def app_get_problems():
    response = {"success": False}
    if flask.request.method == "GET":
        response = db.get_entry('App', 'Problems')
    return flask.jsonify(response)


@app.route("/app/find_practitioner", methods=["GET"])
def app_get_problems():
    response = {"success": False}
    if flask.request.method == "GET":
        patient_id = request.args.get('patient_id')
        # for now given a problem retrieve all available practitioner
        problem_id = request.args.get('problem_id')
        # map problem_id to problem label
        data = load_template_data('template_data/problems.json')
        ids = data['ids']
        indx = ids.index(problem_id)
        problem_name = data['name'][indx]
        collection = 'Medteam'
        query = {'Areas': {'$in': [problem_name]}}
        response = db.get_entry('Accounts', collection, query=query, filter=filter)
    return flask.jsonify(response)


@app.route("/accounts", methods=["POST", "GET"])
def med_find_users():
    response = {"success": False}

    if flask.request.method == "GET":
        collection = request.args.get('collection')
        if collection == "Medteam":
            if 'filter_by' in request.args:
                filters = ['languages', 'Specialities', 'Areas', 'id']
                filter_by = request.args.get('filter_by', type=str)
                if filter_by not in filters:
                    return response
                if filter_by == 'id':
                    query = {'id': request.args.get('id')}
                    filter = False
                else:
                    filter_list = request.args.get('filter_list', type=str)
                    filter_list = filter_list.split(',')
                    filter_list = [element.replace(' ', '') for element in filter_list]
                    #query = {'languages': {'$in': ['Tamil', 'English'] }}
                    query = {filter_by: {'$in': filter_list}}
                    filter = True
            else:
                # get all results
                filter=False
                query= None

            response = db.get_entry('Accounts', collection, query=query, filter=filter)

        elif collection == "Patients":
            query = {'id': request.args.get('id')}
            filter = False
            response = db.get_entry('Accounts', collection, query=query, filter=filter)

    if flask.request.method == "POST":
        collection = request.form.get('collection', type=str)
        if collection == "Medteam":
            operation = request.form.get('operation', type=str)
            operations = ['add_user', 'update_user']
            if operation not in operations:
                return response

        elif collection == "Patients":
            operation = request.form.get('operation', type=str)
            operations = ['add_user', 'update_user']
            if operation not in operations:
                return response

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
