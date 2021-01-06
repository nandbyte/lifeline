import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifeline/components/custom_dropdown_menu.dart';
import 'package:lifeline/components/custom_text_field.dart';
import 'package:lifeline/components/rounded_button.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/models/profile_data.dart';
import 'package:lifeline/screens/user_dashboard_screen.dart';
import 'package:lifeline/services/authenticate.dart';
import 'package:lifeline/services/database.dart';
// import 'package:flutter/services.dart';

class UserProfileScreen extends StatefulWidget {
  static String id = 'user_profile';

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final database = new Database(uid: Auth().getUID());

  final name = new TextEditingController();
  String gender;
  final age = new TextEditingController();
  String blood;
  final contact = new TextEditingController();
  final emergency = new TextEditingController();
  final govtID = new TextEditingController();
  final otherID = new TextEditingController();
  final location = new TextEditingController();
  //final name = new TextEditingController();
  Timestamp selectedDate = Timestamp.now();
  TextEditingController _date = new TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.toDate(),
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate.toDate()) {
      setState(() {
        selectedDate = Timestamp.fromDate(picked);
        _date.value = TextEditingValue(text: DateFormat.yMd().format(picked));
      });
    }
  }

  Future<void> _submit() async {
    final _name = name.text;
    final _age = age.text;
    final _contact = contact.text;
    final _emergency = emergency.text;
    final _gender = gender;
    final _bloodGroup = blood;
    final _govtID = govtID.text;
    final _otherID = otherID.text;
    final _location = location.text;
    final _dob = selectedDate;
    ProfileData person = new ProfileData(
      name: _name,
      age: _age,
      contact: _contact,
      emergency: _emergency,
      gender: _gender,
      blood: _bloodGroup,
      dob: _dob,
      govtID: _govtID,
      otherID: _otherID,
      location: _location,
      donorStatus: await database.getStatus(),
    );
    print(person.toMap());
    database.createProfile(person);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UserDashboardScreen()));
  }

  int count = 0;
  ProfileData person;
  Future<void> loadCurrentData() async {
    String uid = Auth().getUID();
    final data = await Database(uid: uid).getData(uid);
    setState(() {
      person = data;
      name.text = person.name;
      age.text = person.age;
      contact.text = person.contact;
      emergency.text = person.emergency;
      gender = person.gender;
      blood = person.blood;
      govtID.text = person.govtID;
      otherID.text = person.otherID;
      location.text = person.location;
      selectedDate = person.dob;
      _date.text = DateFormat.yMd().format(selectedDate.toDate());
    });
  }

  @override
  void initState() {
    loadCurrentData();
    // if (person != null) {
    //   setState(() {
    //     //count++;
    //     //it's used otherwise you will not be able to input
    //     //because each frame it will fetch
    //     //now for every user it's fetching 2 times
    //   });
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        title: Expanded(
          child: Row(
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  height: 40.0,
                  child: Image.asset(
                    'assets/images/lifeline_logo.png',
                  ),
                ),
              ),
              Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Nexa Bold',
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black54,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CustomTextField(
                label: "Name",
                hint: "Full Name",
                controller: name,
                keyboardType: TextInputType.text,
              ),
              CustomTextField(
                label: "Age",
                hint: "Age in Years",
                controller: age,
                keyboardType: TextInputType.number,
              ),
              CustomTextField(
                label: "Phone Number",
                hint: "Phone",
                controller: contact,
                keyboardType: TextInputType.phone,
              ),
              CustomTextField(
                label: "Emergency Contact",
                hint: "Emergency Contact Number",
                controller: emergency,
                keyboardType: TextInputType.phone,
              ),
              CustomDropdownMenu(
                label: 'Gender',
                items: ['Male', 'Female'],
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
              CustomDropdownMenu(
                label: "Blood Group",
                items: [
                  'A+',
                  'A-',
                  'B+',
                  'B-',
                  'AB+',
                  'AB-',
                  'O+',
                  'O-',
                ],
                onChanged: (value) {
                  setState(() {
                    blood = value;
                  });
                },
              ),
              CustomTextField(
                label: "Address",
                hint: "Street Address",
                controller: location,
                keyboardType: TextInputType.streetAddress,
              ),
              CustomTextField(
                label: 'Government ID',
                hint: 'National ID/ Birth Certificate ID',
                controller: govtID,
                keyboardType: TextInputType.number,
              ),
              CustomTextField(
                label: 'Professional ID',
                hint: 'Office/Student ID',
                controller: otherID,
                keyboardType: TextInputType.number,
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: CustomTextField(
                    label: "Birth Date",
                    hint: "Select your Date of Birth",
                    controller: _date,
                    keyboardType: TextInputType.datetime,
                  ),
                ),
              ),
              Container(
                child: RoundedButton(
                  onPressed: _submit,
                  text: 'Update',
                  color: Colors.green[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Geolocator() {}
}
