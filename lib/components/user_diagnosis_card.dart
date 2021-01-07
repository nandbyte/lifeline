import 'package:flutter/material.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/models/blood_donor.dart';
import 'package:lifeline/models/diagnosis.dart';

class UserDiagnosisCard extends StatelessWidget {
  final Donor targetUser;
  final Diagnosis targetDiagnosis;

  UserDiagnosisCard({
    this.targetUser,
    this.targetDiagnosis,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              this.targetUser.name + '\'s Diagnosis',
              style: kTextStyle.copyWith(
                fontSize: 28,
                color: Colors.green[900],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Name: ' + this.targetUser.name,
              style: kTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Blood Group: ' + this.targetUser.blood,
              style: kTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Contact: ' + this.targetUser.contact,
              style: kTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Location: ' + this.targetUser.location,
              style: kTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Problem Type: ' + this.targetDiagnosis.type,
              style: kTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Description: ' + this.targetDiagnosis.problem,
              style: kTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Date: ' + this.targetDiagnosis.date,
              style: kTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
