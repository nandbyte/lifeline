import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/models/blood_donor.dart';
import 'package:lifeline/models/diagnosis.dart';
import 'package:lifeline/models/profile_data.dart';
import 'package:lifeline/services/api_path.dart';

class Database {
  final String uid;
  CollectionReference users = FirebaseFirestore.instance.collection('profile');
  Database({@required this.uid}) : assert(uid != null);

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    var snapshot =
        await FirebaseFirestore.instance.collection('profile').doc(uid).get();
    if (snapshot.exists)
      reference.update(data);
    else
      reference.set(data);
  }

  Future<void> createProfile(ProfileData profile) async {
    await _setData(path: APIPath.profile(uid), data: profile.toMap());
  }

  Future<void> createEmptyProfile(ProfileData profile) async {
    await _setData(path: APIPath.profile(uid), data: profile.toMap());
  }

  Future<ProfileData> getData(String uid) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('profile').doc(uid).get();
    if (snapshot.exists)
      return ProfileData(
        name: snapshot.data()['Name'] ?? '',
        age: snapshot.data()['Age'] ?? '',
        dob: snapshot.data()['Birth Date'] ?? '',
        blood: snapshot.data()['Blood Group'] ?? '',
        contact: snapshot.data()['Contact No'] ?? '',
        emergency: snapshot.data()['Emergency No'] ?? '',
        gender: snapshot.data()['Gender'] ?? '',
        govtID: snapshot.data()['Govt ID'] ?? '',
        location: snapshot.data()['Location'] ?? '',
        otherID: snapshot.data()['Other ID'] ?? '',
        donorStatus: snapshot.data()['Donor Status'],
        lastDonation: snapshot.data()['Last Donation'],
      );
    else
      return ProfileData(
          contact: '',
          blood: '',
          name: '',
          age: '',
          dob: Timestamp.now(),
          gender: '',
          govtID: '');
  }

  Future<String> getName() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('profile').doc(uid).get();
    if (snapshot.exists)
      return snapshot.data()['Name'];
    else {
      return "Complete your profile";
    }
  }

  Future<String> getGovtID() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('profile').doc(uid).get();
    if (snapshot.exists)
      return snapshot.data()['Govt ID'];
    else {
      return '';
    }
  }

  Future<void> updateDonorStatus(bool donorStatus) async {
    return users
        .doc(uid)
        .update({'Donor Status': donorStatus})
        .then((value) => print("Status updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<bool> getStatus() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('profile').doc(uid).get();
    if (snapshot.exists)
      return snapshot.data()['Donor Status'];
    else {
      return false;
    }
  }

  Future<void> updateLocation(String latitute, String longitude) {
    return FirebaseFirestore.instance.collection('profile').doc(uid).update({
      "Latitute": latitute,
      "Longitude": longitude,
    });
  }

  List<Donor> donors;

  Future<QuerySnapshot> donorList(String blood) async {
    return await FirebaseFirestore.instance
        .collection('profile')
        .where('Blood Group', isEqualTo: blood)
        .where('Donor Status', isEqualTo: true)
        .where('Latitute', isNotEqualTo: null)
        .where('Longitude', isNotEqualTo: null)
        .get();
  }

  Future<QuerySnapshot> searchUserWithGovernmentID(String id) async {
    return await FirebaseFirestore.instance
        .collection('profile')
        .where('Govt ID', isEqualTo: id)
        .get();
  }

  Future<QuerySnapshot> searchUserWithAdditionalID(String id) async {
    return await FirebaseFirestore.instance
        .collection('profile')
        .where('Other ID', isEqualTo: id)
        .get();
  }
  //Future<QuerySnapshot>
  Future<bool> verifyDoctor(String doctorID) async {
    final _govtID = await getGovtID();
    var snapshot =
        await FirebaseFirestore.instance.collection('doctor').doc(doctorID).get();
    final _fetchedID = await snapshot.data()['Govt ID'];
    if(_govtID == _fetchedID)
      return true;
    else
      return false;
  }

  Future<Diagnosis> getRecord(String _uid,String _recordID) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('health_record').doc(_uid)
              .collection('history').doc(_recordID).get();
    if (snapshot.exists)
      return Diagnosis(
        date: snapshot.data()['Date'],
        type: snapshot.data()['Type'],
        problem: snapshot.data()['Problem'],
        verified: false
      );
    else
      return null;
  }
}

