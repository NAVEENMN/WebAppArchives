import 'package:flutter/material.dart';

class userView extends StatefulWidget {
  
  final String user_uid;
  final TabController control;
  userView(this.user_uid, this.control);

  @override
  _userViewState createState() => _userViewState();
}

class _userViewState extends State<userView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // get user data from database
    // if it doesnt exist create account

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}