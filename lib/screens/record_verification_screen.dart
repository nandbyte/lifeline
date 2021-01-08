import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lifeline/components/rounded_button.dart';
import 'package:lifeline/components/user_diagnosis_card.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/models/blood_donor.dart';
import 'package:lifeline/models/diagnosis.dart';
import 'package:lifeline/services/authenticate.dart';
import 'package:lifeline/services/database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RecordVerificationScreen extends StatefulWidget {
  static String id = 'record_verification';

  @override
  _RecordVerificationScreenState createState() =>
      _RecordVerificationScreenState();
}

class _RecordVerificationScreenState extends State<RecordVerificationScreen> {
  bool loadingIndicator = false;
  String qrCodeResult;
  List<String> qrData;
  String qrCodeType;
  String diagnosisID; // contained fetched diagnosis ID after scanning
  String uID; // contained fetched UID after scanning

  Diagnosis qrDiagnosis;
  Donor qrDonor;

  final database = Database(uid: Auth().getUID());

  Future<void> cardData(String _uid, String _recordID) async {
    print(_uid);
    print(_recordID);
    final _profile = await database.getData(_uid);
    final _diagnosis = await database.getRecord(_uid, _recordID);
    final _qrDonor = new Donor(
      name: _profile.name,
      contact: _profile.contact,
      location: _profile.location,
      blood: _profile.blood,
    );
    setState(() {
      qrDiagnosis = _diagnosis;
      qrDonor = _qrDonor;
    });
    //print(qrDiagnosis.toMap());
    print(qrDonor.toMap());
  }

  Future<void> _verify(String _uID, String _id) async {
    return database.updateRecord(_uID, _id);
  }

  Widget getUserDiagnosisCard() {
    if (qrCodeResult == null || qrDonor == null || qrDiagnosis == null) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
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
          child: Text(
            'No Information. Please scan to get diagnosis report.',
            textAlign: TextAlign.center,
            style: kTextStyle.copyWith(
              fontSize: 24,
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: UserDiagnosisCard(
          targetDiagnosis: qrDiagnosis,
          targetUser: qrDonor,
        ),
      );
    }
  }

  Widget getVerifyButton() {
    if (qrDiagnosis == null) {
      return SizedBox(height: 1);
    } else if(qrDiagnosis.verified == true) {
  return SizedBox(height: 1);
      }else {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: RoundedButton(
          text: 'Verify',
          color: Colors.green[900],
          onPressed: () async {
            setState(() {
              loadingIndicator = true;
            });
            _verify(uID, diagnosisID);
            Navigator.of(context).pop();
            setState(() {
              loadingIndicator = false;
            });
          },
        ),
      );
    }
  }

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              getUserDiagnosisCard(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RoundedButton(
                  text: 'Open Camera',
                  color: Colors.green[900],
                  onPressed: () async {
                    String codeScanner = await BarcodeScanner.scan();

                    setState(() {
                      qrCodeResult = codeScanner;
                    });

                    qrData = codeScanner.split('_');
                    qrCodeType = qrData[0];
                    diagnosisID = qrData[1];
                    uID = qrData[2];

                    if (qrCodeType != null) {
                      if (qrCodeType == 'LIFELINE_DIAGNOSIS') {
                        setState(() {
                          loadingIndicator = true;
                        });
                        await cardData(uID, diagnosisID);
                        setState(() {
                          loadingIndicator = false;
                        });
                      }
                    }
                  },
                ),
              ),
              getVerifyButton(),
            ],
          ),
        ),
      ),
    );
  }
}
