import json
import pymongo
from bson import json_util
from monogo_schema import *

class database():
    def __init__(self):
        db_url = "mongodb+srv://test_user:test@cluster0-onaoj.mongodb.net/"
        db_url = db_url + "test?retryWrites=true&w=majority"
        self.client = pymongo.MongoClient(db_url)
        #create_dummy_schema(self.client)
        #create_problems_list(self.client)
        self.dbs = self.client.list_database_names()

    def add_entry(self, db_name, coll_name, data):
        resp = dict()
        resp['success'], resp['payload'] = False, None
        if (db_name in self.dbs) and (coll_name in self.client[db_name].list_collection_names()):
            ref = self.client[db_name][coll_name]
            try:
                post_id = ref.insert_one(data).inserted_id
                resp['success'] = True
                resp['payload'] = {'_id': None}
                print("inserted", post_id)
            except:
                resp['success'] = False
                print("insert failed")
        else:
            resp['success'] = False
            resp['payload'] = {'error':' Invalid collection'}
            print("invalid db or collection")     
        return resp

    def delete_entry(self, db_name, coll_name, query, delete_many=False):
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
                print("delete failed")
        else:
            resp['success'] = False
            resp['payload'] = json.dumps({'error':' Invalid collection'})
            print("invalid db or collection")     
        return json.dumps(resp)

    def get_entry(self, db_name, coll_name, query=None):
        resp = dict()
        resp['success'] = False
        if (db_name in self.dbs) and (coll_name in self.client[db_name].list_collection_names()):
            ref = self.client[db_name][coll_name]
            try:
                values = [ref.find_one(query)] if query else [ref.find_one()]
                vals = [json.loads(json_util.dumps(val)) for val in values]
                resp['payload'] = vals
                resp['success'] = True
            except:
                resp['success'] = False
                print("find failed")
        else:
            resp['success'] = False
            resp['payload'] = {'error':' Invalid collection'}
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
            resp['payload'] = {'error':' Invalid collection'}
            print("invalid db or collection")     
        return resp

    def get_collections(self, coll_name):
        print(self.collections)
        if coll_name in self.collections:
            print(True)
        print(self.client[coll_name])

def main():
    db = database()
    #db.get_collections('Users')
    #data = json.dumps({'name':'naveen'})
    #db.add_entry('Users', 'account', json.loads(data))
    #db.delete_entry('Users', 'account', query={'name': 'naveen'}, delete_many=True)
    #db.find_entry('Medteam', 'Accounts', query={'specialities': ['Ayurveda'] }, all_entry=True)
    #r = db.find_entry('Medteam', 'Accounts', query={'user_id':'91235'}, all_entry=False)
    #r = db.find_entry('Medteam', 'Accounts', query={'languages':{'$in': ['Tamil', 'English'] }}, all_entry=True)
    #print(r)
    r = db.get_entry('App', 'problems')
    print(r)
if __name__ == "__main__":
    main()
