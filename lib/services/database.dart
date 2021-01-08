import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/models/blood_donor.dart';
import 'package:lifeline/models/profile_data.dart';
import 'package:lifeline/services/api_path.dart';

class Loc {
  String lat;
  String long;
  Loc({this.lat, this.long});
  Map<String, dynamic> toMap() {
    return {
      "Latitute": lat,
      "Longitude": long,
      //"Latitude": lat,
    };
  }
}

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

  // Future<List<Donor>> donorList(String blood) async {
  //   await FirebaseFirestore.instance
  //       .collection('profile')
  //       .where('Blood Group', isEqualTo: blood)
  //       .where('Donor Status', isEqualTo: true)
  //       .where('Latitute', isNotEqualTo: null)
  //       .where('Longitude', isNotEqualTo: null)
  //       //.orderBy('Age',descending: true)
  //       //.where('Age',isGreaterThanOrEqualTo: 18)
  //       .get()
  //       .then((QuerySnapshot value) {
  //     if (value.docs.isNotEmpty) {
  //       for (int i = 0; i < value.docs.length; i++) {
  //         //if(value.docs[i].data()['Donor Status']==true)
  //         //print('Name: ${value.docs[i].data()['Name']}\tContact: ${value.docs[i].data()['Contact No']}');
  //         final data = value.docs[i].data();
  //         final dummy = Donor(
  //             blood: data['Blood Group'],
  //             contact: data['Contact No'],
  //             latitute: data['Latitute'],
  //             longitude: data['Longitute'],
  //             location: data['Location'],
  //             name: data['Name']);
  //         donors.insert(i, dummy);
  //       }
  //     }
  //   });
  //   print(donors[0]);
  //   return donors;
  // }
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
  Future<QuerySnapshot> bloodDonorList(String blood) async {
    return await FirebaseFirestore.instance
        .collection('profile')
        //.where('Blood Group', isEqualTo: blood)
        .where('Donor Status', isEqualTo: true)
        .where('Latitute', isNotEqualTo: null)
        .where('Longitude', isNotEqualTo: null)
        .get();
  }

  Future<DocumentSnapshot> getLoc() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('profile').doc(uid).get();
    return snapshot;
  }
}
