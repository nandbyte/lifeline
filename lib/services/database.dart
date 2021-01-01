import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/models/profile_data.dart';
import 'package:lifeline/services/api_path.dart';

class Database {
  final String uid;
  Database({@required this.uid}) : assert(uid != null);

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    reference.set(data);
  }

  Future<void> createProfile(ProfileData profile) async {
    await _setData(path: APIPath.profile(uid), data: profile.toMap());
  }
}
