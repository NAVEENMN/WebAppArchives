import 'package:flutter/material.dart';

class accounttab extends StatefulWidget {
  @override
  _accounttabState createState() => _accounttabState();
}

class _accounttabState extends State<accounttab> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 4,
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: accountCreate(),
            ),
          ),
          Center(
            child: Text('2'),
          ),
          Center(
            child: Text('3'),
          ),
          Center(
            child: Text('4'),
          ),
          Center(
            child: Text('5'),
          ),
          Center(
            child: Text('6'),
          ),
        ],
      ),
    );
  }
}

Widget accountCreate() {

  final _formKey = GlobalKey<FormState>();
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();

  // Email Section
    final emailField = TextFormField(
      controller: email_controller,
      decoration: const InputDecoration(hintText: 'Email'),
      validator: (value) => value.isEmpty ? 'Please enter email': null,
    );

    // Password Section
    final passwordField = TextFormField(
      obscureText: true,
      controller: password_controller,
      decoration: const InputDecoration(hintText: 'Password'),
      validator: (value) => value.isEmpty ? 'Please enter your password':null,
    );

    // Submit Button Section
    final signupButton = RaisedButton(
      color: Colors.lightGreen,
      onPressed: () async {
        print('test');
        if (_formKey.currentState.validate()) {
          //User _user = User(email_controller.text, password_controller.text);
          //print(_user.toJson());
          //get_data();
          // if success result will be user else null
          //dynamic result = await _auth.registerWithEmailAndPassword(email_controller.text, password_controller.text);
          //if (result == null) {
            print("Failed to Sign Up");
          //}
        }
        print('test');
      },
      child: Text(
        "Create account",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
    
  return Column(
    children: <Widget>[
      Text(
        'Account Create',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        ),
      Form(
        child: Column(
          key: _formKey,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 18.0),
              child: emailField,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 18.0),
              child: passwordField,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 18.0),
              child: signupButton,
            ),
          ],
        ),
      )
    ],
  );
}