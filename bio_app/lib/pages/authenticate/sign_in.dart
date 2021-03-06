import 'package:bio/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    email_controller.dispose();
    password_controller.dispose();
    super.dispose();
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
    final signinButton = RaisedButton(
      color: Colors.lightGreen,
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          dynamic result = await _auth.signInWithEmailAndPassword(email_controller.text, password_controller.text);
          if (result == null) {
            print("Failed to Sign In");
          }
        }
      },
      child: Text(
        "Sign In",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    // Submit Button Section
    final toggleButton = FlatButton(
      color: Colors.white,
      onPressed: () {
        widget.toggleView();
      },
      child: Text(
        "Sign Up",
        style: TextStyle(
          color: Colors.green,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
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
                  child: signinButton,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('want a new account?'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: toggleButton,
                    )
                  ],
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
