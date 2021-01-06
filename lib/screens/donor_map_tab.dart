import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lifeline/components/custom_dropdown_menu.dart';
import 'package:lifeline/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

double selfX;
double selfY;

double getUserLat() {
  selfX = 23.7925;
  return selfX;
}

double getUserLong() {
  selfY = 90.4078;
  return selfY;
}

class Donor {
  String id;
  double lat;
  double long;
  String bg;
  String name;
  String location;
  String contact;

  Donor(this.id, this.lat, this.long, this.bg, this.name, this.location,
      this.contact);
  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'lat': lat,
      'long': long,
      'bg': bg,
      'id': id,
      'location': location,
      'contact': contact,
    };
  }
}

class DonorMapTab extends StatefulWidget {
  @override
  _DonorMapTabState createState() => _DonorMapTabState();
}

class _DonorMapTabState extends State<DonorMapTab> {
  final GlobalKey scaffoldKey = GlobalKey();

//Donor

  Donor donor1 =
      new Donor("1", 23.7925, 90.4078, "A+", "Saif", "Dhaka", "0173029526");
  Donor donor2 =
      new Donor("2", 23.8103, 90.4125, "B+", "Adib", "Dhaka", "0130882088");

  List<Donor> list = [];

  Completer _controller = Completer();
  Map<MarkerId, Marker> markers = {};
  double ownX, ownY;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(getUserLat(), getUserLong()),
    zoom: 14.0,
  );
  List listMarkerIds = [];

  @override
  void initState() {
    list.add(donor1);
    list.add(donor2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
// //         appBar: AppBar(
// //           leadingWidth: 0,
// //           title: CustomDropdownMenu(
// //             label: "Blood Group",
// //             items: [
// //               'A+',
// //               'A-',
// //               'B+',
// //               'B-',
// //               'AB+',
// //               'AB-',
// //               'O+',
// //               'O-',
// //             ],
// //             onChanged: (value) async {
// // // TODO: Implement map search functionality

// //               // setState(() {
// //               //   blood = value;
// //               // });

// //               // setState(() {
// //               //   blood = value;
// //               //   loadingIndicator = true;
// //               // });

// //               // await fetchDonorList(blood);
// //               // donors = [];
// //               // for (int i = 0; i < snapshot.docs.length; i++) {
// //               //   donors.add(
// //               //     Donor(
// //               //         blood: snapshot.docs[i].data()['Blood Group'],
// //               //         contact: snapshot.docs[i].data()['Contact No'],
// //               //         latitute: snapshot.docs[i].data()['Latitute'] ?? '',
// //               //         longitude: snapshot.docs[i].data()['Longitude'] ?? '',
// //               //         location: snapshot.docs[i].data()['Location'],
// //               //         name: snapshot.docs[i].data()['Name']),
// //               //   );
// //               // }

// //               // setState(() {
// //               //   loadingIndicator = false;
// //               // });
// //             },
// //           ),
//           // backgroundColor: Colors.white,
//           // shadowColor: Colors.black54,
//         ),
        body: Stack(children: <Widget>[
          Container(
            child: GoogleMap(
              initialCameraPosition: _kGooglePlex,
              onTap: (_) {},
              mapType: MapType.normal,
              markers: Set.of(markers.values),
              onMapCreated: (GoogleMapController controler) {
                _controller.complete(controler);
                for (int i = 0; i < list.length; i++) {
                  MarkerId markerId1 = MarkerId(list[i].id);

                  listMarkerIds.add(markerId1);

                  Marker marker1 = Marker(
                      markerId: markerId1,
                      position: LatLng(list[i].lat, list[i].long),
                      icon: (list[i].lat == getUserLat() &&
                              list[i].long == getUserLong())
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
                            // var bottomSheetController = Scaffold.of(
                            //         scaffoldKey.currentContext)
                            //     .showBottomSheet((context) => Container(
                            //           child: getBottomSheet(list[i]),
                            //           height: 250,
                            //           color: Colors.transparent,
                            //         ));
                          },
                          snippet: list[i].bg));

                  setState(() {
                    markers[markerId1] = marker1;
                  });
                }
              },
            ),
          ),
          Container(
            child: CustomDropdownMenu(
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
                
              },
            ),
          ),
        ]));
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
                color:
                    (donor.lat == getUserLat() && donor.long == getUserLong())
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
                          Text(donor.bg,
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
                  Text((donor.lat).toString() + "," + (donor.long).toString())
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
