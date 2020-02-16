import 'package:app/models/server.dart';
import 'package:app/models/user.dart';
import 'package:app/pages/home/views/adminView.dart';
import 'package:app/pages/home/views/userView.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var client = http.Client();

class Home extends StatefulWidget {
  final String user_uid;
  
  Home(this.user_uid);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  
  TabController control;
  server ser = server();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    control = new TabController(vsync: this, length: 3);
    var res = get_user_details(widget.user_uid);
  }

  @override
  void dispose() {
    control.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future get_user_details(userId) async {
    var response;
    print("here");
    String url = "http://${ser.serverIp}/accounts";
    var data = await client.get(url, headers: {"collection": "Medteam", "filter_by": "id", "id": userId});
    var jsonData = json.decode(data.body);
    print("after");
    print(jsonData);
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user_uid == "RbbXreHWQ4gmsEQzEVOeez2KyIE2") {
      return adminView(widget.user_uid, control);
    } else {
      // check if user info is valid if not take them to register page
      
      return userView(widget.user_uid, control);
    }
  }
}

