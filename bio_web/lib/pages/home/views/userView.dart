import 'package:app/models/fontstyling.dart';
import 'package:app/models/pallet.dart';
import 'package:app/models/patients.dart';
import 'package:app/models/user.dart';
import 'package:app/pages/home/tabs/patientstab.dart';
import 'package:app/pages/home/tabs/reportstab.dart';
import 'package:app/pages/wrapper.dart';
import 'package:app/services/firebasedb.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class userView extends StatefulWidget {

  final User usr;
  final TabController control;
  final Utils utils;

  userView({this.usr, this.control, this.utils});

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
          pageBuilder: (BuildContext context, _, __) => getUserDetailsScreen(widget.usr, widget.utils)));
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

    String name = "";
    String email = "";
    String _location = "";
    String professionalDescription = "";
    String profileImageUrl = "https://vivly.s3-us-west-2.amazonaws.com/profileImages/${widget.usr.uid}.jpg";

    if (widget.usr.isUpdate) {
      name = "${widget.usr.name_.title}. ${widget.usr.name_.firstName} ${widget.usr.name_.lastName}";
      email = widget.usr.profession_.designation;
      _location = "${widget.usr.location_.cityName}, ${widget.usr.location_.stateName}";
      professionalDescription = widget.usr.profession_.description;
      profileImageUrl = "https://vivly.s3-us-west-2.amazonaws.com/profileImages/${widget.usr.uid}.jpg";
      print('image url');
      print(profileImageUrl);
    }

    return Scaffold(
      appBar: AppBar(
        title: fontText('HELIX', 'Montserrat', true, Colors.white, 1.5),
        centerTitle: true,
        backgroundColor: widget.utils.pallet.shadePolite0,
        bottom: TabBar(
          controller: widget.control,
          indicatorColor: widget.utils.pallet.shadePolite3,
          tabs: <Widget>[
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.people),
                  SizedBox(width: 2,),
                  fontText('My Patients', 'Montserrat', false, Colors.white, 1.5),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.chat),
                  SizedBox(width: 2,),
                  fontText('Public Cases', 'Montserrat', false, Colors.white, 1.5),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.assignment),
                  SizedBox(width: 2,),
                  fontText('Research Metrics', 'Montserrat', false, Colors.white, 1.5),
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
              accountName: fontText(name, 'Esteban', false, Colors.black, 1.5),
              accountEmail: fontText(email, 'Esteban', false, Colors.black, 1.5),
              decoration: BoxDecoration(
                image:DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/background/background.png")
                )
              ),
            ),
            ListTile(
              title: Text("Location"),
              subtitle: fontText(_location, 'Esteban', false, Colors.black, 1.5),
              trailing: Icon(Icons.location_on),
            ),
            ListTile(
              title: Text("Description"),
              subtitle: fontText(professionalDescription, 'Esteban', false, Colors.black, 1.5),
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background/homeBackground.png"),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.all(10),
              child: TabBarView(
              controller: widget.control,
              children: <Widget>[
                Center(
                  child: patientsTab(widget.usr, Patients(widget.usr), widget.utils.fdb),
                ),
                Center(
                  child: reportsTab(widget.usr, widget.utils.fdb),
                ),
                Center(
                  child: Text('Reseach topics of you intrests and curated medical stats will appear here'),
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
  final Utils utils;
  getUserDetailsScreen(this.usr, this.utils);

  @override
  _getUserDetailsScreenState createState() => _getUserDetailsScreenState();
}

class _getUserDetailsScreenState extends State<getUserDetailsScreen> {

  final _formKey = GlobalKey<FormState>();

  Widget createTextField(TextEditingController controller, String label, String hint, String errorMsg, int length) {
    
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      color: widget.utils.pallet.shadePolite3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          fontText(label, 'Esteban', true, widget.utils.pallet.shadePolite0, 1.8),
          TextFormField(
            style: TextStyle(
              color: widget.utils.pallet.shadeBlue,
              fontWeight: FontWeight.normal
            ),
            maxLength: length,
            controller: controller,
            decoration: const InputDecoration(hintText: ''),
            validator: (value) => value.isEmpty ? errorMsg : null,
          )
        ],
      ),
    );
  }

@override
  Widget build(BuildContext context) {

    Pallet pallet = Pallet();

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

    // Filter section
    List<String> _title = ['Mr', 'Mrs', 'Dr'];
    String _selectedtitle;
    final titleField = DropdownButton(
      hint: Text('Title'),
      value: _selectedgender,
      onChanged: (newValue) {
        setState(() {
          _selectedgender = newValue;
        });
      },
      items: _title.map((element){
        return DropdownMenuItem(
          child: Text(element),
          value: element,
        );
      }).toList(),
    );
    
    // Designation field
    final designationController = TextEditingController();
    final designationField = TextFormField(
      maxLength: 8,
      controller: designationController,
      decoration: const InputDecoration(hintText: 'Designation'),
      validator: (value) => value.isEmpty ? 'Please enter your Designation': null,
    );

    final NameController = TextEditingController();
    final LocationController = TextEditingController();
    final DesignationController = TextEditingController();
    final UniversityController = TextEditingController();
    final SpecializationController = TextEditingController();
    final DescriptionController = TextEditingController();
    
        // Submit Button
    final submitButton = RaisedButton(
      color: Colors.lightGreen,
      onPressed: () async {
        print("submit");
        widget.usr.isUpdate = true;
        widget.usr.name_.firstName = NameController.text.toString();
        widget.usr.profession_.designation = DesignationController.text.toString();
        widget.usr.education_.universityName = UniversityController.text.toString();
        widget.usr.profession_.specialities = SpecializationController.text.split(", ");
        widget.usr.profession_.description = DesignationController.text.toString();
        //String payload = User.toJson(widget.usr);
        // String userId = widget.usr.uid.toString();
        //var resourceData = jsonEncode({'collection': 'Medteam', 'operation': 'addUser', 'userId': userId, 'payload': payload});
        await widget.usr.updateUserDetails(widget.utils.fdb);
        // Navigator.pop(context);
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
            fontText('Please provide more details', 'Montserrat', true, pallet.shadePolite0, 2),
            Container(
              padding: EdgeInsets.fromLTRB(50, 50, 50, 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    createTextField(NameController, "Name", "Add your name", "Please enter your Name", 50),
                    createTextField(DesignationController, "Designation", "Add your Designation", "Please add your Designation", 10),
                    createTextField(UniversityController, "University", "Add your University", "Please add your University", 20),
                    createTextField(SpecializationController, "Specialization", "Add your Specilization", "Please add your Specilization", 20),
                    createTextField(DescriptionController, "Description", "Add your Description", "Please add your Description", 100),
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