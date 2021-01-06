import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:lifeline/components/rounded_button.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsPages extends StatefulWidget {
  @override
  _TermsPagesState createState() => _TermsPagesState();
}

class _TermsPagesState extends State<TermsPages> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          title: Row(
            children: [
              Container(
                height: 40.0,
                child: Image.asset(
                  'assets/images/lifeline_logo.png',
                ),
              ),
              Center(
                child: Text(
                  'Terms And Conditions',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Nexa Bold',
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.black54,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AutoSizeText(
                    'Welcome to Lifeline,this are the terms and conditions for our application.',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nexa Bold',
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 10.0),
                  AutoSizeText(
                    '-Lifeline will access your location through GPS.',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 10.0),
                  AutoSizeText(
                    '-Lifeline will access your camera for scanning.',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 10.0),
                  AutoSizeText(
                    '-Any user  within the app can view your public health information.',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                    maxLines: 2,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 10.0),
                  AutoSizeText(
                    '-Medical Professionals can acess your private health information.',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                    maxLines: 2,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 10.0),
                  AutoSizeText(
                    '-Any user found accountable for misusing data will be penaltalized through HIPAA policy.',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                    maxLines: 3,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 30.0),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'For more Information ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height / 35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'Click Here',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            const url =
                                "https://www.hhs.gov/hipaa/for-professionals/privacy/laws-regulations/index.html";
                            if (await canLaunch(url)) {
                              await launch(url,
                                  forceSafariVC: true, forceWebView: true);
                            } else {
                              throw "Cannot launch url";
                            }
                          },
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: MediaQuery.of(context).size.height / 35,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ]),
                  ),
                  RoundedButton(
                      text: 'Agree', color: Colors.green[900], onPressed: () {})
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
