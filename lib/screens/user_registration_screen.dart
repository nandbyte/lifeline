import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/components/rounded_button.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/screens/user_dashboard_screen.dart';
import 'package:lifeline/services/authenticate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class UserRegistrationScreen extends StatefulWidget {
  static String id = 'user_register';

  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  String email;
  String password;

  bool loadingIndicator = false;

     Widget _hipaabutton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40),
          //child: FlatButton(
           // onPressed: () {},
            child: RichText(
            maxLines: 2,
            overflow:TextOverflow.ellipsis,
            softWrap: false,
              text: TextSpan(children: [
                TextSpan(
                  text: 'You must agree with HIPAA policy to continue. \n',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.height / 50,
                  ),
                ),
                TextSpan(
                  text: 'Click Here',
                  style:TextStyle(
                    color: Colors.blue,
                    fontSize: MediaQuery.of(context).size.height / 40,
                    fontWeight: FontWeight.w400,
                  ),
                  recognizer: TapGestureRecognizer()..onTap =() async{
                   var url="https://codeforces.com/";
                    if(await canLaunch(url)){
                     await launch(url);
                    }else{
                      throw "Cannot Load Url";
                    }
                  }
                )
              ]),
            textAlign: TextAlign.justify,
            ),
          ),
        //),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          color: Colors.white,
          opacity: 0.9,
          progressIndicator: kWaveLoadingIndicator,
          inAsyncCall: loadingIndicator,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Container(
                        height: 200.0,
                        child: Image.asset('assets/images/lifeline_logo.png'),
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
                    _hipaabutton(),
                    SizedBox(
                      height: 24.0,
                    ),
                    RoundedButton(
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
