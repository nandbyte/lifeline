import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/components/rounded_button.dart';
import 'package:lifeline/screens/user_login_screen.dart';
import 'package:lifeline/screens/user_registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Hero(
                        tag: 'logo',
                        child: Container(
                          child: Image.asset(
                            'assets/images/lifeline_logo.png',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TypewriterAnimatedTextKit(
                            text: [
                              'LifeLine',
                            ],
                            textStyle: TextStyle(
                              fontSize: 50.0,
                              fontFamily: 'Nexa Bold',
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                            speed: Duration(
                              milliseconds: 200,
                            ),
                          ),
                          Text(
                            'Electronic Health Record',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Nexa',
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 48.0,
                ),
                RoundedButton(
                  text: 'Log In',
                  color: Colors.green[900],
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      UserLoginScreen.id,
                    );
                  },
                ),
                RoundedButton(
                  text: 'Register',
                  color: Colors.green[700],
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      UserRegistrationScreen.id,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
