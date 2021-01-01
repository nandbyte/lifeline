import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/models/profile_data.dart';
import 'package:lifeline/services/authenticate.dart';
import 'package:lifeline/services/database.dart';

class userProfile extends StatefulWidget {
  @override
  _userProfileState createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
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
    );
    print(person.toMap());
    database.createProfile(person);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Data"),
        backgroundColor: Theme.of(context).appBarTheme.color,
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            createTextField(
                context: context,
                label: 'Name',
                hint: 'Enter your name',
                controller: name),
            createTextField(
                context: context,
                label: 'Name',
                hint: 'Enter your name',
                controller: name),
            createTextField(
                context: context,
                label: 'Name',
                hint: 'Enter your name',
                controller: name),
            createTextField(
                context: context,
                label: 'Name',
                hint: 'Enter your name',
                controller: name),
            createTextField(
                context: context,
                label: 'Name',
                hint: 'Enter your name',
                controller: name),
          ],
        ),
      ),
    );
  }
}
