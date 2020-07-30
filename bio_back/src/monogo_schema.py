import logging
import json
import pymongo
from bson import json_util

def set_logging():
    logger = logging.getLogger('db_logger')
    formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
    ch = logging.StreamHandler()
    logger.setLevel(logging.INFO)
    ch.setFormatter(formatter)
    logger.addHandler(ch)
    return logger


log = set_logging()


def data_clean_up(data):
    def lower_key(in_dict):
        if type(in_dict) is dict:
            out_dict = {}
            for key, item in in_dict.items():
                out_dict[key.lower()] = lower_key(item)
            return out_dict
        elif type(in_dict) is list:
            return [lower_key(obj) for obj in in_dict]
        else:
            return in_dict
    cleaned = lower_key(data)
    return cleaned

def load_template_data(path):
    data = {}
    with open(path) as json_file:
        data = json.load(json_file)
    return data


def check_if_doc_exist(ref, query):
    log.info('Checking if document exists: %s', query)
    status = True if ref.find(query).count() > 0 else False
    if status:
        log.info('Document found')
    else:
        log.info('Document not found')
    return status


def create_meeting_room(client):
    room_id = '34532'
    ref = client['Meetings'][room_id]
    payload = dict()
    payload['users'] = ['91234', '1234']
    payload['start_time'] = '12:00pm'
    ref.insert_one(payload)


def create_med_team_account(client):
    log.info('Creating med team accounts: db { %s }, collection { %s }', 'Accounts', 'Medteam')
    ref = client['Accounts']['Medteam']
    data = load_template_data('template_data/medteam_accounts.json')
    for dat in data:
        query = {'name': data[dat]['name']}
        exists = check_if_doc_exist(ref, query=query)
        if exists:
            log.info('Deleting this document/record')
            ref.delete_one(query)
        log.info('Creating new document/record')
        ref.insert_one(data[dat])


def create_patients_account(client):
    log.info('Creating patient accounts: db { %s }, collection { %s }', 'Accounts', 'Patients')
    ref = client['Accounts']['Patients']
    data = load_template_data('template_data/patient_accounts.json')
    for dat in data:
        query = {'name': data[dat]['name']}
        exists = check_if_doc_exist(ref, query=query)
        if exists:
            log.info('Deleting this document/record')
            ref.delete_one(query)
        log.info('Creating new document/record')
        ref.insert_one(data[dat])


def create_user_account(client):
    ref = client['Users']['Accounts']
    payload = dict()
    payload['user_id'] = '1234'
    payload['name'] = 'Naveen Mysore'
    payload['location'] = 'Milpitas'
    payload['Age'] = '29'
    ref.insert_one(payload)


def create_problems_list(client):
    log.info('Creating Problems data: db { %s }, collection { %s }', 'App', 'Problems')
    ref = client['App']['Problems']
    data = load_template_data('template_data/problems.json')
    log.info('Deleting existing documents')
    ref.drop()
    log.info('Creating new documents')
    ref.insert_one(data)


def create_dummy_schema(client):
    create_user_account(client)
    create_med_team_account(client)
    create_meeting_room(client)


def main():
    db_url = "mongodb+srv://test_user:test@cluster0-onaoj.mongodb.net/"
    db_url = db_url + "test?retryWrites=true&w=majority"
    client = pymongo.MongoClient(db_url)
    create_med_team_account(client)
    create_patients_account(client)
    create_problems_list(client)


if __name__ == "__main__":
    main()
