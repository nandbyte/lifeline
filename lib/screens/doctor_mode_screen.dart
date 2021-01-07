import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lifeline/components/custom_text_field.dart';
import 'package:lifeline/components/rounded_button.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/screens/doctor_dashboard_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class DoctorModeScreen extends StatefulWidget {
  static String id = 'doctor_mode';

  @override
  _DoctorModeScreenState createState() => _DoctorModeScreenState();
}

class _DoctorModeScreenState extends State<DoctorModeScreen> {
  bool loadingIndicator = false;

  TextEditingController doctorIdController = new TextEditingController();

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
              'Doctor Mode',
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
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  'Verify yourself with your',
                  style: kTextStyle.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'BMDC registration number',
                  style: kTextStyle.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                label: 'Doctor Registration Number',
                hint: 'BMDC Registration Number',
                controller: doctorIdController,
                keyboardType: TextInputType.number,
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
                    // TODO: If verified push to doctor dashboard
                    Navigator.pushNamed(context, DoctorDashboardScreen.id);
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
    );
  }
}
