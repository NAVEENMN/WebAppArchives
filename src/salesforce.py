import json
from db import *
import logging
from simple_salesforce import Salesforce

def set_logging():
    logger = logging.getLogger('salesforce_logger')
    formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
    ch = logging.StreamHandler()
    logger.setLevel(logging.INFO)
    ch.setFormatter(formatter)
    logger.addHandler(ch)
    return logger


log = set_logging()

class salesforce():
    def __init__(self, db=database()):
        self.db = db
        entry = db.get_entry('Credentials', 'Salesforce')
        self.sf = Salesforce(username=entry['payload'][0][0]['email'],
                             password=entry['payload'][0][0]['password'],
                             security_token=entry['payload'][0][0]['token'])

    def update_record(self):
        pass

    '''
    payload input is a dict
    '''
    def insert_record(self, obj, payload):
        resp = dict()
        resp['success'] = False
        fields = ", ".join(payload.keys())
        values = ", ".join([str(payload[key]) for key in payload.keys()])
        query = "INSERT INTO %s (%s) VALUES (%s)" % (obj, fields, values)
        log.info('Running query : %s', query)
        result = self.sf.query(query)
        print(result)

    def update_bulk_record(self):
        pass


    def get_query(self, att, obj, cond=None):
        resp = dict()
        resp['success'] = False
        try:
            attributes = ", ".join(att)

            if cond:
                query = "SELECT %s FROM %s WHERE %s" % (attributes, obj, cond)
            else:
                query = "SELECT %s FROM %s" % (attributes, obj)

            log.info('Running query : %s', query)
            result = self.sf.query(query)
            if result['done']:
                log.info("Operation status : done",)
                payload = dict()
                for sf_res in result['records']:
                    record = dict()
                    for key in sf_res:
                        record[key] = sf_res[str(key)]
                    payload[sf_res['Id']] = record
                resp['success'] = True
                resp['payload'] = payload
            else:
                log.error('Error: %s', result)
        except:
            log.error('Error: get_query Operation failed')

        return resp


def main():
    sf = salesforce()
    attr = ["ID", "First_Name__c"]
    res = sf.get_query(attr, "Patient__c")
    print(res)
    data = dict()
    data['age__c'] = 28
    data['First_Name__c'] = 'Adam'
    data['Last_Name__c'] = 'Smith'
    #res = sf.sf.restful("/services/data/v38.0/sobjects/Accounts", method='GET', params=None)
    #print(res)

    #res = sf.sf.apexecute('/services/data/v38.0/sobjects/Patient__c', method='POST', data=data)
    #print(res)
    attr = ["ID", "Name"]
    #res = sf.get_query(attr, "Account", cond="Email = 'navimn1991@gmail.com'")
    #print(res)
    res = sf.sf.Patient.create({'Name': 'Smith Ad'})
    print(res)

if __name__ == "__main__":
    main()
