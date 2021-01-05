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
  bool ready = false;
  final database = Database(uid: Auth().getUID());
  CollectionReference databaseReference;
  QuerySnapshot snapshot;
  final blood = new TextEditingController();

  List<Donor> donors;

  Future<void> fetchDonorList(String str) async {
    snapshot = await database.donorList(str);
  }

  void createList() {
    donors = [];
    Donor snapshotDonor = new Donor();
    for (int i = 0; i < snapshot.docs.length; i++) {
      snapshotDonor = Donor(
          blood: snapshot.docs[i].data()['Blood Group'],
          contact: snapshot.docs[i].data()['Contact No'],
          latitute: snapshot.docs[i].data()['Latitute'] ?? '',
          longitude: snapshot.docs[i].data()['Longitude'] ?? '',
          location: snapshot.docs[i].data()['Location'],
          name: snapshot.docs[i].data()['Name']);

      donors.add(snapshotDonor);
    }
  }

  @override
  void initState() {
    donors = [];
    donors.add(
      Donor(
        blood: 'B+',
        name: 'Adib',
        contact: '01797130904',
        location: 'Dhaka',
      ),
    );
    donors.add(
      Donor(
        blood: 'B+',
        name: 'Saif',
        contact: '01797136704',
        location: 'Dhaka',
      ),
    );
    donors.add(
      Donor(
        blood: 'O+',
        name: 'Shihab',
        contact: '01797136344',
        location: 'Gazipur',
      ),
    );

    databaseReference = database.users;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.white,
      opacity: 0.9,
      progressIndicator: kWaveLoadingIndicator,
      inAsyncCall: loadingIndicator,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextFormField(
              controller: blood,
              keyboardType: TextInputType.text,
              onEditingComplete: () {
                print(blood.text);
                setState(() async {
                  loadingIndicator = true;
                  await fetchDonorList(blood.text);
                  createList();
                  print(donors.length);
                  loadingIndicator = false;
                  this.build(context);
                });
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
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: donors.length,
                  itemBuilder: (context, index) {
                    return DonorInfoCard(donor: donors[index]);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
