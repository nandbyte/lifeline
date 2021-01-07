import 'package:flutter/material.dart';
import 'package:lifeline/components/alert_dialog_form.dart';
import 'package:lifeline/components/verifiable_diagnosis_card_list.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/models/diagnosis.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MedicalHistoryScreen extends StatefulWidget {
  static String id = 'medical_history';
  @override
  _MedicalHistoryScreenState createState() => _MedicalHistoryScreenState();
}

class _MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  bool loadingIndicator = false;
  List<Diagnosis> diagnosisList = [
    Diagnosis(
      type: 'Disease',
      problem: 'COVID19',
      date: 'December, 2020',
    ),
    Diagnosis(
      type: 'Accident',
      problem: 'Thorax Fracture',
      date: 'November, 2020',
      verified: true,
      verifiedBy: 'Dr. Who',
    ),
    Diagnosis(
      type: 'Accident',
      problem: 'Leg Fracture',
      date: 'January, 2019',
    ),
  ];

  @override
  void initState() {
    setState(() {
      loadingIndicator = true;
    });
    // TODO: Fetch all diagnosis data and put that into diagnosisList
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
