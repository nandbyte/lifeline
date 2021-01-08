import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/components/diagnosis_card_list.dart';
import 'package:lifeline/components/rounded_button.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/models/blood_donor.dart';
import 'package:lifeline/models/diagnosis.dart';
import 'package:lifeline/services/EHR.dart';
import 'package:lifeline/services/authenticate.dart';
import 'package:lifeline/services/database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CheckRecordScreen extends StatefulWidget {
  static String id = 'check_record';

  @override
  _CheckRecordScreenState createState() => _CheckRecordScreenState();
}

class _CheckRecordScreenState extends State<CheckRecordScreen> {
  bool loadingIndicator = true;
  // List<Diagnosis> diagnosisList = [
  //   Diagnosis(
  //     type: 'Disease',
  //     problem: 'COVID19',
  //     date: 'December, 2020',
  //     verified: true,
  //     verifiedBy: 'Dr. Corona Chang',
  //   ),
  //   Diagnosis(
  //     type: 'Accident',
  //     problem: 'Thorax Fracture',
  //     date: 'November, 2020',
  //   ),
  //   Diagnosis(
  //     type: 'Accident',
  //     problem: 'Leg Fracture',
  //     date: 'January, 2019',
  //   ),
  // ];

// Dialo
  final erhRecord = EHR(uid: Auth().getUID());
  CollectionReference reference;
  QuerySnapshot snapshot;

  String qrCodeResult;
  List<String> qrData;
  String qrCodeType;
  String uID; // contained fetched UID after scanning
  bool allDataFetched =
      false; // This is the bool that tracks if all getch data has been completed
  Donor qrDonor;

  List<Diagnosis> diagnosisList;

  Future<List<Diagnosis>> fetchHistory(String _uid) async {
    List<Diagnosis> _diagnosisList = [];
    final _erhRecord = EHR(uid: _uid);
    snapshot = await _erhRecord
        .historySnap(); // I guess you need a clone of this function with a uid parameter
    for (int i = 0; i < snapshot.docs.length; i++) {
      var _history = snapshot.docs[i];
      print(_history.data());
      _diagnosisList.add(new Diagnosis(
        type: _history.data()['Type'],
        date: _history.data()['Date'],
        problem: _history.data()['Problem'],
        verified: _history.data()['Verified'],
        verifiedBy: _history.data()['VerifiedBy'],
      ));
    }
    setState(() {
      diagnosisList = _diagnosisList;
    });
    return diagnosisList;
  }

  void nonAsync(String _uid) {
    fetchHistory(_uid);
  }

  @override
  void initState() {
    diagnosisList = [];
    //nonAsync(_uid);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> recordData(String _uid, String _recordID) async {
    print(_uid);
    print(_recordID);
    final database = Database(uid: _uid);
    final _profile = await database.getData(_uid);

    final _qrDonor = new Donor(
      name: _profile.name,
      contact: _profile.contact,
      location: _profile.location,
      blood: _profile.blood,
    );
    setState(() {
      qrDonor = _qrDonor;
    });
    //print(qrDiagnosis.toMap());
    print(qrDonor.toMap());
  }

  Widget showScanOrListWidget() {
    if (allDataFetched == false) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: RoundedButton(
          text: 'Open Camera',
          color: Colors.green[900],
          onPressed: () async {
            String codeScanner = await BarcodeScanner.scan();

            setState(() {
              qrCodeResult = codeScanner;
            });
            print("I'm the hunter $codeScanner");
            qrData = codeScanner.split('_');
            qrCodeType = qrData[0];
            uID = qrData[1];

            print("Here am I to print $qrCodeType");

            print(uID);
            //if (qrCodeType != null) {
            //if (qrCodeType == 'LIFELINE_DIAGNOSIS') {
            setState(() {
              loadingIndicator = true;
            });
            await fetchHistory(uID); // Change this for taking uID only
            setState(() {
              loadingIndicator = false;
            });
            //}
            //}
          },
        ),
      );
    } else {
      return Expanded(
        child: DiagnosisCardList(
          diagnosisList: diagnosisList,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //fetchHistory();
    loadingIndicator = false;
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
              'Check Record',
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              showScanOrListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
