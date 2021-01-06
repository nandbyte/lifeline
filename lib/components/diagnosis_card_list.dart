import 'package:flutter/cupertino.dart';
import 'package:lifeline/components/diagnosis_card.dart';
import 'package:lifeline/models/diagnosis.dart';

class DiagnosisCardList extends StatefulWidget {
  final List<Diagnosis> diagnosisList;
  DiagnosisCardList({this.diagnosisList});
  @override
  _DiagnosisCardListState createState() => _DiagnosisCardListState();
}

class _DiagnosisCardListState extends State<DiagnosisCardList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.widget.diagnosisList.length,
        itemBuilder: (context, index) {
          return DiagnosisInfoCard(diagnosis: this.widget.diagnosisList[index]);
        });
  }
}
