import 'package:app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class createAccountPage extends StatelessWidget {

  final FirebaseAuth _adminAuth;
  final Function update_log;

  createAccountPage(this._adminAuth, this.update_log);  

  @override
  Widget build(BuildContext context) {

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
      validator: (value) => value.isEmpty ? 'Please enter your password': null,
    );

    // Sign up with email and password
    Future adminRegisterAccountWithEmailAndPassword(String email, String password) async {
      try {
        AuthResult result = await _adminAuth.createUserWithEmailAndPassword(email: email, password: password);
        FirebaseUser user = result.user;
        return user;
      } catch (e) {
        print(e.toString());
        update_log(e.toString());
        return null;
      }
  }

    // Submit Button Section
    final signupButton = RaisedButton(
      color: Colors.lightGreen,
      onPressed: () async {        
        if (_formKey.currentState.validate()) {
          update_log("Registering account");
          dynamic result = await adminRegisterAccountWithEmailAndPassword(email_controller.text, password_controller.text);
          if (result == null) {
            update_log('Account Registration failed');
            print("Failed to Sign Up");
          }
        } else {
          update_log("Form invalid");
        }
      },
      child: Text(
        "Sign Up",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            emailField,
            passwordField,
            signupButton
          ],
        ),
      ),
    );
  }
}