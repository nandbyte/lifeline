import 'package:flutter/material.dart';
import 'package:lifeline/components/rounded_button.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/screens/user_dashboard_screen.dart';
import 'package:lifeline/services/authenticate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class UserRegistrationScreen extends StatefulWidget {
  static String id = 'user_register';

  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  String email;
  String password;

  bool loadingIndicator = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        color: Colors.white,
        opacity: 0.9,
        progressIndicator: kWaveLoadingIndicator,
        inAsyncCall: loadingIndicator,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('assets/images/lifeline_logo.png'),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'User Registration',
                  style: kTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    this.email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: "Email"),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  obscureText: true,
                  onChanged: (value) {
                    this.password = value;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: "Password"),
                ),
              ),
              Expanded(
                flex: 1,
                child: RoundedButton(
                  text: 'Register',
                  color: Colors.green[900],
                  onPressed: () async {
                    setState(() {
                      loadingIndicator = true;
                    });

                    try {
                      final user =
                          await Auth().register(this.email, this.password);
                      if (user != null)
                        Navigator.pushNamed(context, UserDashboardScreen.id);
                      setState(() {
                        loadingIndicator = false;
                      });
                    } catch (e) {
                      print(e);
                      Toast.show(
                        e.message,
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.TOP,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
