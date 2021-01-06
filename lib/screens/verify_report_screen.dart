import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lifeline/components/rounded_button.dart';
import 'package:lifeline/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class VerifyReportScreen extends StatefulWidget {
  static String id = 'verify_report';

  @override
  _VerifyReportScreenState createState() => _VerifyReportScreenState();
}

class _VerifyReportScreenState extends State<VerifyReportScreen> {
  bool loadingIndicator = false;

  String doctorID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 0,
        title: Row(
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                height: 40.0,
                child: Image.asset(
                  'assets/images/lifeline_logo.png',
                ),
              ),
            ),
            Text(
              'ID Verification',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Nexa Bold',
                fontSize: 24,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black54,
      ),
      body: ModalProgressHUD(
        color: Colors.white,
        opacity: 0.9,
        progressIndicator: kWaveLoadingIndicator,
        inAsyncCall: loadingIndicator,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    this.doctorID = value;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: "Doctor ID"),
                ),
                RoundedButton(
                  text: 'Verify',
                  color: Colors.green[900],
                  onPressed: () async {
                    setState(() {
                      loadingIndicator = true;
                    });

                    try {
                      // TODO: Verify Doctor ID here
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
    );
  }
}
