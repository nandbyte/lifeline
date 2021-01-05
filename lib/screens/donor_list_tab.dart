import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/components/donor_info_card.dart';
import 'package:lifeline/models/blood_donor.dart';
import 'package:lifeline/services/authenticate.dart';
import 'package:lifeline/services/database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DonorListTab extends StatefulWidget {
  // TODO: Import donor list from firebase and turn it into a list. Use Listbuilder method to create DonorInfoCard List from the donor list and show in the screen.

  @override
  _DonorListTabState createState() => _DonorListTabState();
}

class _DonorListTabState extends State<DonorListTab> {
  bool loadingIndicator = false;

  final database = Database(uid: Auth().getUID());

  final blood = new TextEditingController();

  List<Donor> donors = [];

  Future<void> makeDonorList(String str) async {
    final snapshot = await database.donorList(str);
    Donor dummy = new Donor();
    for (int i = 0; i < snapshot.docs.length; i++) {
      dummy = Donor(
          blood: snapshot.docs[i].data()['Name'],
          contact: snapshot.docs[i].data()['Contact No'],
          latitute: snapshot.docs[i].data()['Latitute'] ?? '',
          longitude: snapshot.docs[i].data()['Longitude'] ?? '',
          location: snapshot.docs[i].data()['Location'],
          name: snapshot.docs[i].data()['Name']);
      setState(() {
        donors[i] = dummy;
      });
    }
  }

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.white,
      opacity: 0.9,
      progressIndicator: kWaveLoadingIndicator,
      inAsyncCall: loadingIndicator,
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            child: TextFormField(
                controller: blood,
                keyboardType: TextInputType.text,
                onEditingComplete: () {
                  print(blood.text);
                  makeDonorList(blood.text);
                  print(donors.length);
                },
                decoration: InputDecoration(
                  hintText: "A+/A-/B+/B-/AB+/AB-/O+/O-",
                  labelText: "Search Blood Donor",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  hintStyle: TextStyle(
                    fontFamily: 'Nexa',
                  ),
                  labelStyle: TextStyle(
                    fontFamily: 'Nexa',
                  ),
                )),
          ),
          DonorInfoCard(
            name: 'Shihab Sikder',
            bloodGroup: 'B+ve',
            contact: '01793450904',
            location: 'Dhaka',
          ),
          DonorInfoCard(
            name: 'Adib Abrar',
            bloodGroup: 'B+ve',
            contact: '01793450904',
            location: 'Dhaka',
          ),
          DonorInfoCard(
            name: 'Fahim Faisal',
            bloodGroup: 'O-ve',
            contact: '01793450904',
            location: 'Dhaka',
          ),
          DonorInfoCard(
            name: 'Farhan Saif',
            bloodGroup: 'A+ve',
            contact: '01793450904',
            location: 'Dhaka',
          ),
        ],
      ),
    );
  }
}
