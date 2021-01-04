import 'package:flutter/material.dart';
import 'package:lifeline/components/rounded_button.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/screens/user_dashboard_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:lifeline/services/authenticate.dart';
import 'package:toast/toast.dart';

class UserLoginScreen extends StatefulWidget {
  static String id = 'user_login';

  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  String email;
  String password;

  bool loadingIndicator = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: ModalProgressHUD(
            color: Colors.white,
            opacity: 0.9,
            progressIndicator: kWaveLoadingIndicator,
            inAsyncCall: loadingIndicator,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset(
                        'assets/images/lifeline_logo.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      this.email = value;
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: "Email"),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    onChanged: (value) {
                      this.password = value;
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: "Password"),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    text: 'Log In',
                    color: Colors.green[900],
                    onPressed: () async {
                      setState(() {
                        loadingIndicator = true;
                      });
                      try {
                        final user =
                            await Auth().signIn(this.email, this.password);
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
