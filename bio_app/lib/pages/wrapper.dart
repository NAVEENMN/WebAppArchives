import 'package:bio/models/user.dart';
import 'package:bio/pages/authenticate/authenticate.dart';
import 'package:bio/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Return either home or authenticate page
// Depending on signed in or not
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
