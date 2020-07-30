import 'package:app/models/pallet.dart';
import 'package:app/models/user.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/loading.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class SignIn extends StatefulWidget {
  User user;
  SignIn(this.user);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    email_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Pallet pallet = Pallet();
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
          setState(() {
            loading = true;
          });
          dynamic result = await _auth.signInWithEmailAndPassword(email_controller.text, password_controller.text);
          if (result == null) {
            print("Failed to Sign In");
            showSimpleNotification(
              Text("Invalid email or password"),
              background: Colors.lightBlue,
            );
          } else {
            print("Sign in success");
            widget.user.email = email_controller.text;
          }
          setState(() {
            loading = false;
          });
        }
      },
      child: Text(
        "Sign In",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    if (loading) {
      return Loading();
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset('assets/images/logo/logo.png',
                                height: 100,
                                width: 100),
                              ),
                              Text(
                                'HELIX',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: pallet.shadeDark
                                ),
                                )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 50,),
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
                              )
                            ],
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/background/background.png"),
                        fit: BoxFit.cover
                      )
                    )
                  ),
                ),
              ],
            ),
          )
        )
      );
    }
    /*
    return loading ? Loading() : Scaffold(
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
                )
              ],
            ),
          ),
        ),
      )
    );
    */
  }
}