import 'package:flutter/material.dart';
import 'package:lifeline/components/diagnosis_card_list.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/models/diagnosis.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DiagnosisRecordTab extends StatefulWidget {
  @override
  _DiagnosisRecordTabState createState() => _DiagnosisRecordTabState();
}

class _DiagnosisRecordTabState extends State<DiagnosisRecordTab> {
  bool loadingIndicator = false;
  List<Diagnosis> diagnosisList = [
    Diagnosis(
      type: 'Disease',
      problem: 'COVID19',
      date: 'December, 2020',
      verified: true,
      verifiedBy: 'Dr. Corona Chang',
    ),
    Diagnosis(
      type: 'Accident',
      problem: 'Thorax Fracture',
      date: 'November, 2020',
    ),
    Diagnosis(
      type: 'Accident',
      problem: 'Leg Fracture',
      date: 'January, 2019',
    ),
  ];

// Dialo
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
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
              child: DiagnosisCardList(
                diagnosisList: this.diagnosisList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
