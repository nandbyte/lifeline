import 'package:flutter/cupertino.dart';
import 'package:lifeline/components/verifiable_diagnosis_card.dart';
import 'package:lifeline/models/diagnosis.dart';

class VerifiableDiagnosisCardList extends StatefulWidget {
  final List<Diagnosis> diagnosisList;
  VerifiableDiagnosisCardList({this.diagnosisList});
  @override
  _VerifiableDiagnosisCardListState createState() =>
      _VerifiableDiagnosisCardListState();
}

class _VerifiableDiagnosisCardListState
    extends State<VerifiableDiagnosisCardList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.widget.diagnosisList.length,
        itemBuilder: (context, index) {
          return VerifiableDiagnosisCard(
              diagnosis: this.widget.diagnosisList[index]);
        });
  }
}
