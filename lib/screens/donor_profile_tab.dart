import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/components/list_info_card.dart';
import 'package:lifeline/models/profile_data.dart';
import 'package:lifeline/screens/user_profile_screen.dart';
import 'package:lifeline/services/authenticate.dart';
import 'package:lifeline/services/database.dart';

class DonorProfileTab extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<DonorProfileTab> {
  ProfileData profile;
  int fetch = 0;
  bool donorStatus = true;
  Future<void> getInfo() async {
    String uid = Auth().getUID();
    final _profile = await Database(uid: uid).getData(uid);
    setState(() {
      profile = _profile;
      donorStatus = profile.donorStatus;
    });
  }

  Future<void> updateStatus() async {
    String uid = Auth().getUID();
    await Database(uid: uid).updateDonorStatus(donorStatus);
  }

  @override
  Widget build(BuildContext context) {
    if (fetch < 2) {
      getInfo();
      setState(() {
        fetch++;
      });
    }
    if (profile == null && fetch < 2)
      return Scaffold(
        body: SpinKitWave(
          color: Colors.green[700],
        ),
      );
    return ListView(
      children: <Widget>[
        ListInfoCard(
          title: 'Name',
          description: profile.name,
        ),
        ListInfoCard(
          title: 'Contact',
          description: profile.contact,
        ),
        ListInfoCard(
          title: 'Blood Group',
          description: profile.blood,
        ),
        ListInfoCard(
          title: 'Current Location',
          description: profile.location,
        ),
        ListInfoCard(
          title: 'Last Donation',
          description: 'November 23, 2020',
        ),
        ListInfoCard(
          title: 'Gender',
          description: profile.gender,
        ),
        ListInfoCard(
          title: 'Age',
          description: profile.age,
        ),
        GestureDetector(
          onTap: () {},
          child: Card(
            child: SwitchListTile(
              activeColor: Colors.green,
              title: Text(
                'Donor Status',
                style: kTextStyle.copyWith(
                  fontSize: 18,
                ),
              ),
              value: donorStatus,
              onChanged: (bool value) {
                setState(() {
                  donorStatus = value;
                  updateStatus();
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
