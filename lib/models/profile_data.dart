import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileData {
  final String name;
  final String gender;
  final String age;
  final Timestamp dob;
  final String blood;
  final String contact;
  String emergency;
  String govtID;
  String otherID;
  String location;
  Timestamp lastDonation;
  bool donorStatus;

  ProfileData({
    @required this.contact,
    @required this.blood,
    @required this.name,
    @required this.age,
    @required this.dob,
    @required this.gender,
    @required this.govtID,
    this.otherID,
    this.emergency,
    this.location,
    this.lastDonation,
    this.donorStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Gender': gender,
      'Age': age,
      'Birth Date': dob,
      'Blood Group': blood,
      'Contact No': contact,
      'Emergency No': emergency,
      'Govt ID': govtID,
      'Other ID': otherID,
      'Location': location,
      'Last Donation': lastDonation,
      'Donor Status': donorStatus == null ? false : donorStatus,
    };
  }
}
