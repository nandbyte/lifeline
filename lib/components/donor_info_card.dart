import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/models/blood_donor.dart';
import 'package:toast/toast.dart';

class DonorInfoCard extends StatelessWidget {
  final Donor donor;

  DonorInfoCard({this.donor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: this.donor.contact));
        Toast.show(
          'Contact number copied.',
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
        );
      },
      child: Container(
        padding: EdgeInsets.all(24),
        margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
        decoration: BoxDecoration(
          color: Colors.white,
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
            Text(
              this.donor.blood,
              style: kTextStyle.copyWith(
                fontSize: 56,
                color: Colors.green[900],
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              this.donor.name,
              style: kTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
            Text(
              this.donor.contact,
              style: kTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
            Text(
              this.donor.location,
              style: kTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
