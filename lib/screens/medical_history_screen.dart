import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/components/alert_dialog_form.dart';
import 'package:lifeline/components/verifiable_diagnosis_card_list.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/models/diagnosis.dart';
import 'package:lifeline/services/EHR.dart';
import 'package:lifeline/services/authenticate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MedicalHistoryScreen extends StatefulWidget {
  static String id = 'medical_history';
  @override
  _MedicalHistoryScreenState createState() => _MedicalHistoryScreenState();
}

class _MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  bool loadingIndicator = false;
  List<Diagnosis> diagnosisList;
  final erhRecord = EHR(uid: Auth().getUID());
  CollectionReference refference;
  QuerySnapshot snapshot;
  Future<List<Diagnosis>> fetchHistory() async {
    List<Diagnosis> _diagnosisList = [];
    snapshot = await erhRecord.historySnap();
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

  void nonAsync() {
    fetchHistory();
  }

  @override
  void initState() {
    setState(() {
      loadingIndicator = true;
    });
    diagnosisList = [];
    nonAsync();
    setState(() {
      loadingIndicator = false;
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Medical History',
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[900],
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialogForm(
              context: context,
            ),
          );
          setState(() {});
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
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
              Expanded(
                child: VerifiableDiagnosisCardList(
                  diagnosisList: this.diagnosisList,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
