import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final gender = new TextEditingController();
  final age = new TextEditingController();
  final blood = new TextEditingController();
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
    final _gender = gender.text;
    final _bloodGroup = blood.text;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    if (person == null) loadCurrentData();
    if (person != null && count < 2) {
      name.text = person.name;
      age.text = person.age;
      contact.text = person.contact;
      emergency.text = person.emergency;
      gender.text = person.gender;
      blood.text = person.blood;
      govtID.text = person.govtID;
      otherID.text = person.otherID;
      location.text = person.location;
      selectedDate = person.dob;
      _date.text = DateFormat.yMd().format(selectedDate.toDate());
      setState(() {
        count++;
        //it's used otherwise you will not be able to input
        //because each frame it will fetch
        //now for every user it's fetching 2 times
      });
    }

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
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black54,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              createTextFieldText(
                  context: context,
                  label: "Name",
                  hint: "Enter your name",
                  controller: name),
              createTextFieldNumber(
                  context: context,
                  label: "Age",
                  hint: "Enter your Age",
                  controller: age),
              createTextFieldPhone(
                  context: context,
                  label: "Phone No",
                  hint: "Enter your phone number",
                  controller: contact),
              createTextFieldPhone(
                  context: context,
                  label: "Emergency Contact",
                  hint: "Emergency contact number",
                  controller: emergency),
              createTextFieldText(
                  context: context,
                  label: "Gender",
                  hint: "Male/Female/Other",
                  controller: gender),
              createTextFieldText(
                  context: context,
                  label: "Blood Group",
                  hint: "A+/A-/AB+/AB-/B+/B-/O+/O-",
                  controller: blood),
              createTextFieldLocation(
                context: context,
                label: "Address",
                hint: "Area/Village,District,Division",
                controller: location,
              ),
              createTextFieldText(
                  context: context,
                  label: 'Govt Issued ID',
                  hint: 'NID/Passport/Birth ID',
                  controller: govtID),
              createTextFieldText(
                  context: context,
                  label: 'Other ID',
                  hint: 'Office/Student ID',
                  controller: otherID),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: createTextFieldDate(
                    context: context,
                    label: "Birth Date",
                    hint: "Select your date of birth",
                    controller: _date,
                  ),
                ),
              ),
              RoundedButton(
                onPressed: _submit,
                text: 'Update',
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Geolocator() {}
}
