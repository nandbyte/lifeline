/*import 'dart:ffi';
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
    snapshot = await database.bloodDonorList(str);
  }

  List<Donor> list = [];

  Completer _controller = Completer();
  Map<MarkerId, Marker> markers = {};
  List listMarkerIds = [];
  static LatLng initpos;
  void getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      initpos = LatLng(position.latitude, position.longitude);
    });
  }

/////////////////
  ///
  ///
  ///

  ///
  ///
  ///
  @override
  void initState() {
    databaseReference = database.users;

    super.initState();
    getUserLocation();
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
    setState(() {});
    print("Length : " + list[0].name);
  }

  @override
  Widget build(BuildContext contxet) {
    setState(() {});
    //loccup();
    createList("A+");
    // print("lat long self " + lat.toString());
    setState(() {});
    return Scaffold(
        key: scaffoldKey,
        body: Container(
          child: map(),
        ));
  }

  Widget map() {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initpos,
          zoom: 14.00,
        ),
        onTap: (_) {},
        mapType: MapType.normal,
        markers: Set.of(markers.values),
        onMapCreated: (GoogleMapController controler) {
          _controller.complete(controler);
          print(list.length);
          // setState(() {
          //////////
          MarkerId selfid = MarkerId("me");
          listMarkerIds.add(selfid);

          Marker self = Marker(
              markerId: selfid,
              position: LatLng(initpos.latitude, initpos.longitude),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueViolet),
              infoWindow: InfoWindow(title: "you", onTap: () {}, snippet: " "));

          setState(() {
            markers[selfid] = self;
          });

          for (int i = 1; i <= list.length; i++) {
            print("testetstetst");
            print(list[i].toMap());
            MarkerId markerId1 = MarkerId(i.toString());

            listMarkerIds.add(markerId1);

            Marker marker1 = Marker(
                markerId: markerId1,
                position: LatLng(double.parse(list[i].latitute),
                    double.parse(list[i].longitude)),
                icon: (list[i].latitute == initpos.latitude &&
                        list[i].longitude == initpos.longitude)
                    ? BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueViolet)
                    : BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),

                /* icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueCyan),
                          */
                infoWindow: InfoWindow(
                    title: list[i].name,
                    onTap: () {
                      var bottomSheetController =
                          Scaffold.of(scaffoldKey.currentContext)
                              .showBottomSheet((context) => Container(
                                    child: getBottomSheet(list[i]),
                                    height: 250,
                                    color: Colors.transparent,
                                  ));
                    },
                    snippet: list[i].blood));

            setState(() {
              markers[markerId1] = marker1;
            });
          }
          //});
        },
      ),
    );
  }

  Widget getBottomSheet(Donor donor) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 32),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: (donor.latitute == initpos.latitude &&
                        donor.longitude == initpos.longitude)
                    ? Colors.black45
                    : Colors.redAccent,
                //color: Colors.blueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        donor.name,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(donor.blood,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(donor.location,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.map,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text((donor.latitute).toString() +
                      "," +
                      (donor.longitude).toString())
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.call,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(donor.contact)
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
                child: Icon(Icons.navigation), onPressed: () {}),
          ),
        )
      ],
    );
  }
}
*/
