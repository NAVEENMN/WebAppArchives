import 'package:app/models/logging.dart';
import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class getAccountPage extends StatefulWidget {
  adminlogging lg;
  getAccountPage(this.lg);
  @override
  _getAccountPageState createState() => _getAccountPageState();
}

class _getAccountPageState extends State<getAccountPage> {

  Future<User> get_data() async {
      widget.lg.log('Info', 'GET req');
      String url = "http://52.39.96.192/accounts?collection=Medteam&filter_by=id&id=m_1";
      http.Response data = await http.get(
        Uri.encodeFull(url),
        headers: {"Accept": "application/json"}
      );
      print(data);
      var jsonData = json.decode(data.body);
      print(jsonData);
      widget.lg.log('Info', 'response: ${jsonData}');
      return User(uid: "m_1");
    }

  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();

    // Collection Section
    List<String> _collections = ['Medteam', 'App', 'Patients'];
    String _selectedcollection;
    final collectionField = DropdownButton(
      hint: Text('Collection'),
      value: _selectedcollection,
      onChanged: (newValue) {
        _selectedcollection = newValue;
        widget.lg.log("Info", "collection ${_selectedcollection}");
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
        widget.lg.log("Info", "Fliter ${_selectedfilter}");
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
        if (_formKey.currentState.validate()) {
          widget.lg.log("Info", "Getting account details");
          widget.lg.log("Info", "${_selectedfilter} ${_selectedcollection} ${id_controller.text}");
          var res = await get_data();
          print(res);
        } else {
          widget.lg.log("Info", "Form invalid");
        }
      },
      child: Text(
        "Submit",
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
    );
  }
}