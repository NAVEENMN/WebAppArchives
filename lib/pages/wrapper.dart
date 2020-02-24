import 'package:app/models/pallet.dart';
import 'package:app/models/server.dart';
import 'package:app/services/firebasedb.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/models/user.dart';
import 'package:app/pages/authenticate/authenticate.dart';
import 'package:app/pages/home/home.dart';

class Utils {
  Server server;
  Pallet pallet;
  DatabaseService fdb;
  Utils(this.server, this.pallet, this.fdb);
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // all service utils here.
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate(user);
    } else {
      Utils utils = Utils(Server(), Pallet(), DatabaseService(user.uid));
      return Home(user, utils);
    }
  }

}