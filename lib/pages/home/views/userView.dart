import 'package:app/models/fontstyling.dart';
import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class userView extends StatefulWidget {

  final User usr;
  final TabController control;
  userView({this.usr, this.control});

  @override
  _userViewState createState() => _userViewState();
}

class _userViewState extends State<userView> {

  bool refresh = true;

  Future<void> checkUserDetails() async {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!widget.usr.isUpdate) {
        Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) => getUserDetailsScreen(widget.usr)));
        }
    });

  }

  void refreshScreen() async {
    print("Get user details");
    await widget.usr.getUserDetails();
    setState(() {
      refresh = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // get user data from database
    // if it doesnt exist create account
    print("check user details");
    checkUserDetails();
  }

  @override
  Widget build(BuildContext context) {

    String name = "${widget.usr.name_.title}. ${widget.usr.name_.firstName} ${widget.usr.name_.lastName}";
    String email = widget.usr.profession_.designation;
    String _location = "${widget.usr.location_.cityName}, ${widget.usr.location_.stateName}";
    String profileImageUrl = "https://vivly.s3-us-west-2.amazonaws.com/profileImages/${widget.usr.uid}.jpg";

    return Scaffold(
      appBar: AppBar(
        title: fontText('Dashboard', 'Montserrat', true, Colors.white),
        centerTitle: true,
        bottom: TabBar(
          controller: widget.control,
          tabs: <Widget>[
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.assessment),
                  SizedBox(width: 2,),
                  fontText('Patients', 'Montserrat', false, Colors.white),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.people),
                  SizedBox(width: 2,),
                  fontText('Accounts', 'Montserrat', false, Colors.white),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.assignment),
                  SizedBox(width: 2,),
                  fontText('Research', 'Montserrat', false, Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.yellow,
                backgroundImage: NetworkImage(profileImageUrl),
              ),
              accountName: fontText(name, 'Esteban', false, Colors.black),
              accountEmail: fontText(email, 'Esteban', false, Colors.black),
              decoration: BoxDecoration(
                image:DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/background/background.png")
                )
              ),
            ),
            ListTile(
              title: Text("Location"),
              subtitle: fontText(_location, 'Esteban', false, Colors.black),
              trailing: Icon(Icons.location_on),
            ),
            ListTile(
              title: Text("Description"),
              subtitle: fontText(widget.usr.profession_.description, 'Esteban', false, Colors.black),
              trailing: Icon(Icons.assignment),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            flex: 2, 
            child: Container(
              padding: EdgeInsets.all(10),
              child: TabBarView(
              controller: widget.control,
              children: <Widget>[
                Text('Patients'),
                Text('Records'),
                Center(
                  child: Text('To be implemented'),
                  )
                ],
                ),
              )
            ),
        ],
      )
    );
  }
}


class getUserDetailsScreen extends StatefulWidget {
  
  final User usr;
  getUserDetailsScreen(this.usr);

  @override
  _getUserDetailsScreenState createState() => _getUserDetailsScreenState();
}

class _getUserDetailsScreenState extends State<getUserDetailsScreen> {

  final _formKey = GlobalKey<FormState>();

@override
  Widget build(BuildContext context) {

    // Filter section
    List<String> _gender = ['Male', 'Female', 'Non Binary'];
    String _selectedgender;
    final genderField = DropdownButton(
      hint: Text('Gender'),
      value: _selectedgender,
      onChanged: (newValue) {
        setState(() {
          _selectedgender = newValue;
        });
      },
      items: _gender.map((element){
        return DropdownMenuItem(
          child: Text(element),
          value: element,
        );
      }).toList(),
    );

    // First Name field
    final firstNameController = TextEditingController();
    final firstNameField = TextFormField(
      controller: firstNameController,
      decoration: const InputDecoration(hintText: 'First Name'),
      validator: (value) => value.isEmpty ? 'Please enter your First Name': null,
    );

    // Last Name field
    final lastNameController = TextEditingController();
    final lastNameField = TextFormField(
      controller: lastNameController,
      decoration: const InputDecoration(hintText: 'Last Name'),
      validator: (value) => value.isEmpty ? 'Please enter your Last Name': null,
    );

    // Designation field
    final designationController = TextEditingController();
    final designationField = TextFormField(
      maxLength: 8,
      controller: designationController,
      decoration: const InputDecoration(hintText: 'Designation'),
      validator: (value) => value.isEmpty ? 'Please enter your Designation': null,
    );

    // Submit Button
    final submitButton = RaisedButton(
      color: Colors.lightGreen,
      onPressed: () async {
        print("submit");
        widget.usr.isUpdate = true;
        Navigator.pop(context);
      },
      child: Text(
        'Submit',
        style: TextStyle(color: Colors.white,),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Please provide these details."),
            Container(
              padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        genderField,
                        Expanded( // wrap your Column in Expanded
                          child: Column(
                            children: <Widget>[
                              Container(child: firstNameField),
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded( // wrap your Column in Expanded
                          child: Column(
                            children: <Widget>[
                              Container(child: lastNameField),
                            ] ,
                          ),
                        ),
                      ],
                    ),
                    designationField,
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: submitButton,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}