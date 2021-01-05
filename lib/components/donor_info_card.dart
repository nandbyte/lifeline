import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeline/constants.dart';
import 'package:toast/toast.dart';

class DonorInfoCard extends StatelessWidget {
  final String name;
  final String bloodGroup;
  final String contact;
  final String location;

  DonorInfoCard({this.name, this.bloodGroup, this.contact, this.location});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: contact));
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
              this.bloodGroup,
              style: kTextStyle.copyWith(
                fontSize: 56,
                color: Colors.green[900],
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              this.name,
              style: kTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
            Text(
              this.contact,
              style: kTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
            Text(
              this.location,
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
