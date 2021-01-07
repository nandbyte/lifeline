import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lifeline/models/basic_health.dart';
import 'package:lifeline/models/diagnosis.dart';
import 'package:lifeline/services/api_path.dart';
import 'package:lifeline/services/authenticate.dart';

class EHR {
  final String uid;
  EHR({@required this.uid});
  CollectionReference user =
      FirebaseFirestore.instance.collection('health_record');

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    var snapshot = await user.doc(uid).get();
    if (snapshot.exists)
      reference.update(data);
    else
      reference.set(data);
  }

  Future<void> createRecord(basicRecord record) async {
    await _setData(path: APIPath.ehr(uid), data: record.toMap());
  }

  Future<basicRecord> getRecord() async {
    var snapshot = await user.doc(uid).get();
    if (snapshot.exists)
      return basicRecord(
        height: snapshot.data()['Height'] ?? '',
        weight: snapshot.data()['Weight'] ?? '',
        sugerLevel: snapshot.data()['Suger Level'] ?? '~70-140 mg/dL',
        bp: snapshot.data()['Blood Pressure'] ?? '120/80',
        rbc: snapshot.data()['RBC Count'] ?? '~4.7-6.1 mcL',
        wbc: snapshot.data()['WBC Count'] ?? '~9,000-30,000 mcL',
      );
    else
      return basicRecord(
        height: '',
        weight: '',
        sugerLevel: '~70-140 mg/dL',
        rbc: '~4.7-6.1 mcL',
        wbc: '~9,000-30,000 mcL',
        bp: '120/80',
      );
  }

  // History Data Base From Here

  CollectionReference diagnosisRef = FirebaseFirestore.instance
      .collection('health_record')
      .doc(Auth().getUID())
      .collection('history');

  Future<void> _setDiagnosis({String path, Map<String, dynamic> data}) async {
    final referrence = FirebaseFirestore.instance.doc(path);
    var snapshot = await diagnosisRef.doc('history').get();
    await referrence.set(data);
  }

  Future<void> createDiagnosis(Diagnosis diagnosis) async {
    int currentID = await diagnosisRef.snapshots().length ?? 0;
    currentID++;
    print(currentID);
    await _setDiagnosis(
        path: APIPath.diagnosis(uid, currentID.toString()),
        data: diagnosis.toMap());
  }
}
