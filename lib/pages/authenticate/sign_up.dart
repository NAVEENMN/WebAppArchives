import 'package:app/services/auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {

  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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

    void showSnackBar(BuildContext context) {
      final scaffold = Scaffold.of(context);
      final snackBarContent = SnackBar(
        content: Text("sagar"),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      );
      scaffold.showSnackBar(snackBarContent);
    }

    // Submit Button Section
    final signupButton = RaisedButton(
      color: Colors.lightGreen,
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          //User _user = User(email_controller.text, password_controller.text);
          //print(_user.toJson());
          //get_data();
          // if success result will be user else null
          dynamic result = await _auth.registerWithEmailAndPassword(email_controller.text, password_controller.text);
          if (result == null) {
            print("Failed to Sign Up");
          }
        }
      },
      child: Text(
        "Create account",
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
        "Sign In",
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
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: signupButton,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Already a user?'),
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