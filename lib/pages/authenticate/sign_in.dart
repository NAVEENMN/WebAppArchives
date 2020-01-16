import 'package:bio/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: RaisedButton(
          child: Text('Sign In'),
          onPressed: () async {
            // if success result will be user else null
            dynamic result = await _auth.singInAnon();
            if (result == null) {
              print("Failed to Sign In");
            } else {
              print(result.uid);
            }
          },
        ),
      ),
    );
  }
}
