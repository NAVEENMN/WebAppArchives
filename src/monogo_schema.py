def create_meeting_room(client):
    room_id = '34532'
    ref = client['Meetings'][room_id]
    payload = dict()
    payload['users'] = ['91234', '1234']
    payload['start_time'] = '12:00pm'
    ref.insert_one(payload)

def create_med_team_account(client):
    ref = client['Medteam']['Accounts']
    payload = dict()
    payload['user_id'] = '91234'
    payload['name'] = 'Naveen Mysore'
    payload['location'] = 'Milpitas'
    payload['designation'] = 'MD'
    payload['languages'] = ['English', 'Kannada', 'Hindi']
    payload['about_me'] = 'Dr. Naveen is expriened in bla bla bla and has over bla year of     exprience. He pursued his education in bla univesity with a degree in bla.'
    payload['specialities'] = ['Family', 'Pediatry', 'Mental Health']
    ref.insert_one(payload)

def create_user_account(client):
    ref = client['Users']['Accounts']
    payload = dict()
    payload['user_id'] = '1234'
    payload['name'] = 'Naveen Mysore'
    payload['location'] = 'Milpitas'
    payload['Age'] = '29'
    ref.insert_one(payload)

def create_dummy_schema(client):
    create_user_account(client)
    create_med_team_account(client)
    create_meeting_room(client)

def main():
    create_dummy_schema()

if __name__ == "__main__":
    main()
