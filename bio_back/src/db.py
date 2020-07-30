import json
import logging
import pymongo
from bson import json_util
from monogo_schema import *


def set_logging():
    logger = logging.getLogger('db_logger')
    formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
    ch = logging.StreamHandler()
    logger.setLevel(logging.INFO)
    ch.setFormatter(formatter)
    logger.addHandler(ch)
    return logger


log = set_logging()


class database():
    def __init__(self):
        db_url = "mongodb+srv://test_user:test@cluster0-onaoj.mongodb.net/"
        db_url = db_url + "test?retryWrites=true&w=majority"
        self.client = pymongo.MongoClient(db_url)
        self.dbs = self.client.list_database_names()

    def check_if_doc_exist(self, ref, query):
        log.info('Checking if this record exists')
        status = True if ref.find(query).count() > 0 else False
        if status:
            log.info('Document found')
        else:
            log.info('Document not found')
        return status

    def add_entry(self, db_name, coll_name, data, query=None):
        log.info('Adding Entry: db { %s }, collection { %s }', db_name, coll_name)
        resp = dict()
        resp['success'], resp['payload'] = False, None
        if (db_name in self.dbs) and (coll_name in self.client[db_name].list_collection_names()):
            ref = self.client[db_name][coll_name]
            try:
                exists = False
                if query:
                    exists = self.check_if_doc_exist(ref, query=query)
                    if exists:
                        log.info('Deleting this document/record')
                        ref.delete_one(query)
                log.info('Adding a record')
                post_id = ref.insert_one(data).inserted_id
                resp['success'] = True
                resp['payload'] = {'_id': None}
                log.info('Adding entry success')
            except:
                resp['success'] = False
                log.error('Adding entry failed: Operation failed')
        else:
            resp['success'] = False
            resp['payload'] = {'error': ' Invalid collection'}
            log.error('Adding entry failed: Invalid collection')
        return resp

    def delete_entry(self, db_name, coll_name, query, delete_many=False):
        log.info('Delete Entry: db { %s }, collection { %s }', db_name, coll_name)
        log.info('Query %s', query)
        resp = dict()
        resp['success'], resp['payload'] = False, None
        if (db_name in self.dbs) and (coll_name in self.client[db_name].list_collection_names()):
            ref = self.client[db_name][coll_name]
            try:
                if delete_many:
                    post_id = ref.delete_many(query)
                else:
                    post_id = ref.delete_one(query)
                resp['success'] = True
                resp['payload'] = dict({'_id': None})
                print("deleted", post_id)
            except:
                resp['success'] = False
                log.error('Delete entry failed: Operation failed')
        else:
            resp['success'] = False
            resp['payload'] = json.dumps({'error': 'Invalid collection'})
            log.error('Delete entry failed: Invalid collection')
        return json.dumps(resp)

    def get_entry(self, db_name, coll_name, query=None, filter=False):
        log.info('Find Entry: db { %s }, collection { %s }', db_name, coll_name)
        log.info('Filter: %s, Query: %s', filter, query)
        resp = dict()
        resp['success'] = False
        if (db_name in self.dbs) and (coll_name in self.client[db_name].list_collection_names()):
            ref = self.client[db_name][coll_name]
            try:
                if filter:
                    # get all results matching the query
                    values = [ref.find(query)]
                else:
                    # if no query get all the results else find that one record
                    values = [ref.find_one(query)] if query else [ref.find()]
                vals = [json.loads(json_util.dumps(val)) for val in values]
                resp['payload'] = vals
                resp['success'] = True
            except:
                resp['success'] = False
                log.error('Find entry failed: Operation failed')
        else:
            resp['success'] = False
            resp['payload'] = {'error': ' Invalid collection'}
            log.error('Get entry failed: Invalid collection')
        return resp

    def find_users(self, db_name, coll_name, query, all_entry=False):
        resp = dict()
        resp['success'] = False
        if (db_name in self.dbs) and (coll_name in self.client[db_name].list_collection_names()):
            ref = self.client[db_name][coll_name]
            try:
                values = [res for res in ref.find(query)] if all_entry else [ref.find_one(query)]
                vals = [json.loads(json_util.dumps(val)) for val in values] #object id
                payload = dict()
                for val in vals:
                    payload[val['user_id']] = val
                resp['payload'] = payload
                resp['success'] = True
                print("found")
            except:
                resp['success'] = False
                print("find failed")
        else:
            resp['success'] = False
            resp['payload'] = {'error': ' Invalid collection'}
            print("invalid db or collection")     
        return resp

    def get_collections(self, coll_name):
        print(self.collections)
        if coll_name in self.collections:
            print(True)
        print(self.client[coll_name])


def test(db):
    data = load_template_data('template_data/problems.json')
    ids = data['ids']
    problem_id = 'pid_2'
    indx = ids.index(problem_id)
    problem_name = data['name'][indx]
    print(problem_id, problem_name)
    collection = 'Medteam'
    query = {'Areas': {'$in': [problem_name]}}
    response = db.get_entry('Accounts', collection, query=query, filter=filter)
    return response


def main():
    db = database()
    test = json.dumps(load_template_data('template_data/medteam_accounts.json'))
    k = json.loads(test)
    for sam in k:
        data = k[sam]
        print(data, type(data))
        print(data["location"], type(data["location"]))
    #print(test(db))

if __name__ == "__main__":
    main()
