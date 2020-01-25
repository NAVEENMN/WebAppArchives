import json
import pymongo

class database():
    def __init__(self):
        db_url = "mongodb+srv://test_user:test@cluster0-onaoj.mongodb.net/"
        db_url = db_url + "test?retryWrites=true&w=majority"
        self.client = pymongo.MongoClient(db_url)
        self.dbs = self.client.list_database_names()

    def add_entry(self, db_name, coll_name, data):
        resp = dict()
        resp['success'], resp['payload'] = False, None
        if (db_name in self.dbs) and (coll_name in self.client[db_name].list_collection_names()):
            ref = self.client[db_name][coll_name]
            try:
                post_id = ref.insert_one(data).inserted_id
                resp['success'] = True
                resp['payload'] = dict({'_id': None})
                print("inserted", post_id)
            except:
                resp['success'] = False
                print("insert failed")
        else:
            resp['success'] = False
            resp['payload'] = json.dumps({'error':' Invalid collection'})
            print("invalid db or collection")     
        return json.dumps(resp)

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

    def find_entry(self, db_name, coll_name, query, all_entry=False):
        resp = dict()
        resp['success'], resp['payload'] = False, None
        if (db_name in self.dbs) and (coll_name in self.client[db_name].list_collection_names()):
            ref = self.client[db_name][coll_name]
            try:
                if all_entry:
                    for resp in ref.find({}, query):
                        print(resp)
                else:
                    resp = ref.find_one(query)
                    print(resp)
                resp['success'] = True
                resp['payload'] = dict({'_id': None})
                print("found")
            except:
                resp['success'] = False
                print("find failed")
        else:
            resp['success'] = False
            resp['payload'] = json.dumps({'error':' Invalid collection'})
            print("invalid db or collection")     
        return json.dumps(resp)

    def get_collections(self, coll_name):
        print(self.collections)
        if coll_name in self.collections:
            print(True)
        print(self.client[coll_name])

def main():
    db = database()
    #db.get_collections('Users')
    data = json.dumps({'name':'naveen'})
    #db.add_entry('Users', 'account', json.loads(data))
    #db.delete_entry('Users', 'account', query={'name': 'naveen'}, delete_many=True)
    db.find_entry('Users', 'account', query={'name': 'naveen'}, all_entry=True)
if __name__ == "__main__":
    main()
