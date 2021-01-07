import 'dart:ffi';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lifeline/components/custom_dropdown_menu.dart';
import 'package:lifeline/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifeline/screens/donor_list_tab.dart';
import 'dart:async';
import 'package:lifeline/services/authenticate.dart';
import 'package:lifeline/services/database.dart';
import 'donor_list_tab.dart';
import 'package:lifeline/models/blood_donor.dart';
//import 'package:location/location.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'donor_profile_tab.dart';
import 'package:geolocator/geolocator.dart';

class DonorMapTab extends StatefulWidget {
  @override
  _DonorMapTabState createState() => _DonorMapTabState();
}

class _DonorMapTabState extends State<DonorMapTab> {
  final GlobalKey scaffoldKey = GlobalKey();

  bool loadingIndicator = false;

  final database = Database(uid: Auth().getUID());
  CollectionReference databaseReference;
  QuerySnapshot snapshot;

  String blood;

  List<Donor> donors = [];

  Future<void> fetchDonorList(String str) async {
    snapshot = await database.donorList(str);
  }

  String lat, long;
  Future<void> loc() async {
    String uid = Auth().getUID();
    final _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await Database(uid: uid).updateLocation(
        _position.latitude.toString(), _position.longitude.toString());
    lat = _position.latitude.toString();
    long = _position.longitude.toString();
  }

  void loccup() async {
    loc();
  }

  List<Donor> list = [];
  @override
  void initState() {
    databaseReference = database.users;

    super.initState();
  }

  void createList(String blood) async {
    print("test+++");
    await fetchDonorList(blood);

    for (int i = 0; i < snapshot.docs.length; i++) {
      print("xxxxxxx");
      list.add(
        Donor(
            blood: (snapshot.docs[i].data()['Blood Group']).toString(),
            contact: snapshot.docs[i].data()['Contact No'].toString(),
            latitute: snapshot.docs[i].data()['Latitute'].toString() ?? '',
            longitude: snapshot.docs[i].data()['Longitude'].toString() ?? '',
            location: snapshot.docs[i].data()['Location'].toString(),
            name: snapshot.docs[i].data()['Name'].toString()),
      );
    }
    print("Length : " + list[0].name);
  }

  Widget build(BuildContext contxet) {
    loccup();
    createList("A+");

    return Scaffold(body: Text("running"));
  }
}
