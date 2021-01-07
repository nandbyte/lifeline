import 'package:flutter/material.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/models/diagnosis.dart';

class DiagnosisCard extends StatelessWidget {
  // TODO: Create a new model diagnosis and pass it as its parameter
  final Diagnosis diagnosis;

  DiagnosisCard({this.diagnosis});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: this.diagnosis.verified ? Colors.green[100] : Colors.green[50],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
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
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Text(
              this.diagnosis.type,
              style: kTextStyle.copyWith(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Text(
              this.diagnosis.problem,
              style: kTextStyle.copyWith(
                fontSize: 36,
                color: Colors.green[900],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Text(
              this.diagnosis.date,
              style: kTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Text(
              'Verified By: ' +
                  (this.diagnosis.verified
                      ? this.diagnosis.verifiedBy
                      : 'Not yet verified'),
              style: kTextStyle.copyWith(
                fontSize: 16,
                color: Colors.black45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
