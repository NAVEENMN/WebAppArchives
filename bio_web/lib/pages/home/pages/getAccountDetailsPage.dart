import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class getAccountDetailsPage extends StatefulWidget {

  User usr;
  bool userUpToDate;
  getAccountDetailsPage({this.usr, this.userUpToDate});

  @override
  _getAccountDetailsPageState createState() => _getAccountDetailsPageState();
}

class _getAccountDetailsPageState extends State<getAccountDetailsPage> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Collection Section
    List<String> _collections = ['Medteam', 'App', 'Patients'];
    String _selectedcollection;
    final collectionField = DropdownButton(
      hint: Text('Collection'),
      value: _selectedcollection,
      onChanged: (newValue) {
        setState(() {
          _selectedcollection = newValue;
      });
      },
      items: _collections.map((element){
        return DropdownMenuItem(
          child: Text(element),
          value: element,
        );
      }).toList(),
    );

    // Filter section
    List<String> _filterbylist = ['id', 'Languages', 'Patients'];
    String _selectedfilter;
    final filterField = DropdownButton(
      hint: Text('Filter'),
      value: _selectedfilter,
      onChanged: (newValue) {
        _selectedfilter = newValue;
      },
      items: _filterbylist.map((element){
        return DropdownMenuItem(
          child: Text(element),
          value: element,
        );
      }).toList(),
    );

    // Id section
    final id_controller = TextEditingController();
    final idField = TextFormField(
      controller: id_controller,
      decoration: const InputDecoration(hintText: 'Id'),
      validator: (value) => value.isEmpty ? 'Please enter Id': null,
    );

    // Submit Button Section
    final submitButton = RaisedButton(
      color: Colors.lightGreen,
      onPressed: () async {        
        print("submit");
        setState(() {
          widget.userUpToDate = true;
        });
      },
      child: Text(
        "Submit",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Please provide these details"),
      ),
      body: Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                filterField,
                collectionField
              ],
            ),
            idField,
            submitButton
          ],
        ),
      ),
    ),
  );
  }
}