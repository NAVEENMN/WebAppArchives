import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var client = http.Client();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class User {
  final String email;
  final String password;

  User(this.email, this.password);

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        password = json['password'];

  Map<String, dynamic> toJson() =>
      {
        'email': email,
        'password': password,
      };
}

class _LoginState extends State<Login> {

  final email_controller = TextEditingController();
  final password_controller = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    email_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  void get_data() async {
    try {
      var Response = await client.post(
          'http://52.39.96.192/user',
          body: {'name': 'doodle', 'color': 'blue'}
          );
      print(Response.body);
      //print(await client.get(Response.body));
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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
      onPressed: () {
        if (_formKey.currentState.validate()) {
          User _user = User(email_controller.text, password_controller.text);
          print(_user.toJson());
          get_data();
          Navigator.pushNamed(context, '/Dashboard');
        }
      },
      child: Text(
        "Sign Up",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    return Scaffold(
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background/background.png"),
                  fit: BoxFit.cover
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 18.0),
                    child: emailField,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 18.0),
                    child: passwordField,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: signupButton,
                  ),
                  SizedBox(height: 30.0, width: 18.0),
                ],
              ),
          ),
          ),
      )
    );
  }
}
