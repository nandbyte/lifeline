import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lifeline/components/rounded_button.dart';
import 'package:lifeline/components/user_diagnosis_card.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/models/blood_donor.dart';
import 'package:lifeline/models/diagnosis.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RecordVerificationScreen extends StatefulWidget {
  static String id = 'record_verification';

  @override
  _RecordVerificationScreenState createState() =>
      _RecordVerificationScreenState();
}

class _RecordVerificationScreenState extends State<RecordVerificationScreen> {
  bool loadingIndicator = false;

  // TODO: Fetch Diagnosis using diagnosis ID and donor from Donor ID
  Diagnosis qrDiagnosis = Diagnosis(
    type: 'Disease',
    problem: 'COVID19',
    date: 'December, 2020',
  );

  Donor qrDonor = Donor(
    name: 'Patient X',
    contact: '017363213972',
    location: 'Dhaka',
    blood: 'A+',
  );

  // TODO: Fetch QrText and create a InfoCard

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
              'Record Verification',
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: UserDiagnosisCard(
                  targetDiagnosis: qrDiagnosis,
                  targetUser: qrDonor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RoundedButton(
                  text: 'Verify',
                  color: Colors.green[900],
                  onPressed: () {
                    setState(() {
                      loadingIndicator = true;
                    });
                    // TODO: Database update the verified value and approvedBy value of DiagnosisID
                    // TODO: Go Back to Doctor Dashboard screen.
                    setState(() {
                      loadingIndicator = false;
                    });
                  },
                ),
              ),
            ]),
      ),
    );
  }
}
