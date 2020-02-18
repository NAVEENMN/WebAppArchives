import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/models/user.dart';
import 'package:app/pages/authenticate/authenticate.dart';
import 'package:app/pages/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate(user);
    } else {
      return Home(user);
    }
  }
}