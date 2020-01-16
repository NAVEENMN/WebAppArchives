import pymongo

class database():
    def __init__(self):
        conn = "mongodb+srv://test_user:test@cluster0-onaoj.mongodb.net/test?retryWrites=true&w=majority"
        self.client = pymongo.MongoClient(conn)
        self.db = client.test

    def add_entry(self, data):
        post_id = db.posts.insert_one(data).inserted_id
        return post_id
