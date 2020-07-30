import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var client = http.Client();

class Providers extends StatefulWidget {
  @override
  _ProvidersState createState() => _ProvidersState();
}

class _ProvidersState extends State<Providers> {

  void get_med_providers(query) async {
    var response;
    try {
      response = await client.post(
          'http://52.39.96.192/user',
          body: {'query': query}
      );
      response = await client.get(response.body);
      print(response);
    } finally {
      client.close();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Map payload = ModalRoute.of(context).settings.arguments;
    get_med_providers(payload['med_is']);

    return Scaffold(
      backgroundColor: Color(0xFF21BFBD),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF21BFBD),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), onPressed: () {
          Navigator.pop(context);
        },
          color: Colors.black,
        ),
      ),
      body: Text(
          'Hello'
      ),
    );
  }
}

