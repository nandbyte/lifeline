import 'package:flutter/material.dart';
import 'package:lifeline/components/rounded_button.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/models/blood_donor.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchedUserInfoCard extends StatelessWidget {
  final Donor searchedUser;

  SearchedUserInfoCard({this.searchedUser});

  callNumber(BuildContext context, String number) async {
    var url = 'tel://$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show(
        'Cannot launch Phone',
        context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.searchedUser.name != '') {
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
                'Name: ' + this.searchedUser.name,
                style: kTextStyle.copyWith(
                  fontSize: 24,
                  color: Colors.green[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Blood Group: ' + this.searchedUser.blood,
                style: kTextStyle.copyWith(
                  fontSize: 36,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Emergency Contact: ' + this.searchedUser.contact,
                style: kTextStyle.copyWith(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Location: ' + this.searchedUser.location,
                style: kTextStyle.copyWith(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundedButton(
                  text: 'Call Emergency Number',
                  color: Colors.green[900],
                  onPressed: () {
                    callNumber(
                      context,
                      searchedUser.contact,
                    );
                  }),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(24),
        margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
        child: Center(
          child: Text(
            'No User Found',
            style: kTextStyle,
          ),
        ),
      );
    }
  }
}
