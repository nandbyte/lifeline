import 'package:flutter/material.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/screens/welcome_screen.dart';
import 'package:lifeline/services/authenticate.dart';

class LogOutAlertDialog extends StatelessWidget {
  final BuildContext context;

  LogOutAlertDialog({
    @required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Log Out',
        style: kTextStyle.copyWith(
          fontSize: 24,
        ),
      ),
      content: Text(
        'Are you sure you want to log out?',
        style: kTextStyle.copyWith(
          fontSize: 18,
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Auth().signout();
            Navigator.pushNamed(context, WelcomeScreen.id);
          },
          child: Text(
            'Yes',
            style: kTextStyle.copyWith(color: Colors.green, fontSize: 18),
          ),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'No',
            style: kTextStyle.copyWith(color: Colors.green, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
