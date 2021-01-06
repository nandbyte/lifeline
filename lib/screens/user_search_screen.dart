import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lifeline/components/donor_info_card.dart';
import 'package:lifeline/components/rounded_button.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/models/blood_donor.dart';
import 'package:lifeline/services/authenticate.dart';
import 'package:lifeline/services/database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class UserSearchScreen extends StatefulWidget {
  static String id = 'user_search';
  
  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  bool loadingIndicator = false;
  String id;
  final database = Database(uid: Auth().getUID());
  QuerySnapshot snapshot;
  String name='',contact='',blood='',address='';
  Future<void> printMatched(String query) async {
    QuerySnapshot _snapshot = await database.searchUserWithGovt(query);
    if(_snapshot.docs.length == 0)
      _snapshot = await database.searchUserWithOtherID(query);
    if(_snapshot.docs.length == 0)
      print("No user found");
    else{
      for(int i = 0;i<_snapshot.docs.length;i++){
        print(_snapshot.docs[i].data());
        setState(() {
          snapshot = _snapshot;
          name = snapshot.docs[i].data()['Name'];
          contact = snapshot.docs[i].data()['Emergency No'];
          address = snapshot.docs[i].data()['Location'];
          blood = snapshot.docs[i].data()['Blood Group'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 0,
        title: Row(
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                height: 40.0,
                child: Image.asset(
                  'assets/images/lifeline_logo.png',
                ),
              ),
            ),
            Text(
              'Search User',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Nexa Bold',
                fontSize: 24,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black54,
      ),
      body: ModalProgressHUD(
        color: Colors.white,
        opacity: 0.9,
        progressIndicator: kWaveLoadingIndicator,
        inAsyncCall: loadingIndicator,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        this.id = value;
                      });
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: "Any kind of ID number"),
                  ),
                  RoundedButton(
                    text: 'Search',
                    color: Colors.green[900],
                    onPressed: () async {
                      print(" pressed");
                      await printMatched(this.id);
                      print("$name $contact $blood $address");
                      // setState(() {
                      //   loadingIndicator = true;
                      // });

                      // try{
                      //   print("Tapped");
                      //   printMatched(this.name);
                      //   setState(() {
                      //     loadingIndicator = false;
                      //   });
                      // } catch (e) {
                      //   print(e);
                      //   Toast.show(
                      //     e.message,
                      //     context,
                      //     duration: Toast.LENGTH_LONG,
                      //     gravity: Toast.TOP,
                      //   );
                      // }
                    },
                  ),
                  DonorInfoCard(
                    donor: Donor(
                      name: name,
                      contact: contact,
                      blood: blood,
                      location: address,
                      latitute: '',
                      longitude: '',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
