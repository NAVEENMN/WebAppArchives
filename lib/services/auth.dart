import 'package:bio/models/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Authentication Services
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Model user object
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // Sign in Anon
  Future singInAnon() async {
    try {
      // must be enables on Firebase account
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email and password

  // Sign up with email and password

  // Sign out

}