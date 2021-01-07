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

class Loc {
  String lat;
  String long;
  Loc({this.lat, this.long});
  Map<String, dynamic> toMap() {
    return {
      "Longitude": long,
      "Latitude": lat,
    };
  }
}

/*class Donor {
  String id;
  double latitute;
  double longitude;
  String blood;
  String name;
  String location;
  String contact;

  Donor(this.id, this.latitute, this.longitude, this.blood, this.name, this.location,
      this.contact);
  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'latitute': latitute,
      'longitude': longitude,
      'blood': blood,
      'id': id,
      'location': location,
      'contact': contact,
    };
  }
}*/

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
  DocumentSnapshot snapLoc;
  String blood;

  List<Donor> donors;

  Future<void> fetchDonorList(String str) async {
    snapshot = await database.donorList(str);
  }

  Future<void> fetchLoc() async {
    snapLoc = await database.getLoc();
  }
//Donor

  //Donor donor1 =
  // new Donor("farhan", "01309320882", "23.8103", "90.4078", "Dhaka", "A+");
  // Donor donor2 =
  //  new Donor("2", 23.8103, 90.4125, "B+", "Adib", "Dhaka", "0130882088");

  List<Donor> list = [];

  Completer _controller = Completer();
  Map<MarkerId, Marker> markers = {};

  /*static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.7925, 90.4078),
    zoom: 14.0,
  );*/
  List listMarkerIds = [];

  @override
  void initState() {
    //list.add(donor1);
    //list.add(donor2);

    databaseReference = database.users;
    getLoc();
    //getLatLong();
    //locAdd();
    super.initState();
  }

  String lat, long;
  void getLoc() async {
    Loc obj;
    await fetchLoc();
    obj = Loc(
        lat: (snapshot.docs.data()['Latitute']).toString(),
        long: (snapshot.docs.data()['Longitute']).toString());
    lat = obj.lat;
    long = obj.long;
  }

  void createList(String blood) async {
    print("test+++");
    await fetchDonorList(blood);
    List<Donor> donors = [];
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
  }

  @override
  Widget build(BuildContext context) {
    //locAdd();
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leadingWidth: 0,
          title: CustomDropdownMenu(
            label: "Blood Group",
            items: [
              'A+',
              'A-',
              'B+',
              'B-',
              'AB+',
              'AB-',
              'O+',
              'O-',
            ],
            onChanged: (value) async {
              //Position position;

              // TODO: Implement map search functionality

              setState(() {
                blood = value;
              });

              setState(() {
                blood = value;
                loadingIndicator = true;
              });

              createList(blood);
              print(list.length);
              setState(() {
                loadingIndicator = false;
                map(list);
              });
            },
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.black54,
        ),
        body: Container(child: map(list)));
  }

  Widget map(List<Donor> list) {
    // Position location = new Location();

    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(double.parse(lat), double.parse(long)),
      zoom: 14.0,
    );
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        onTap: (_) {},
        mapType: MapType.normal,
        markers: Set.of(markers.values),
        onMapCreated: (GoogleMapController controler) {
          _controller.complete(controler);
          print(list.length);
          for (int i = 0; i < list.length; i++) {
            print("testetstetst");
            print(list[i].toMap());
            MarkerId markerId1 = MarkerId(i.toString());

            listMarkerIds.add(markerId1);

            Marker marker1 = Marker(
                markerId: markerId1,
                position: LatLng(double.parse(list[i].latitute),
                    double.parse(list[i].longitude)),
                icon: (list[i].latitute == 23.7925 &&
                        list[i].longitude == 90.4078)
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
                color: (donor.latitute == 23.7925 && donor.longitude == 90.4078)
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
