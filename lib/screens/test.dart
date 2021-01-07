/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMaps extends StatefulWidget{
  @override
  State createState() {
    // TODO: implement createState
    return MyMapsState();
  }

}
class MyMapsState extends State{
  final GlobalKey scaffoldKey = GlobalKey();

  Completer _controller = Completer();
  Map<MarkerId,Marker> markers = {};
  static final CameraPosition _kGooglePlex =
  CameraPosition(
    target: LatLng(17.4435, 78.3772),
    zoom: 14.0,
  );
  List listMarkerIds=List();
  //final MarkerId markerId = MarkerId("current");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(leading: Icon(Icons.map),
          backgroundColor: Colors.blue,title:
          Text("Google Maps With Markers"),),
        body: Container(
          child: GoogleMap(initialCameraPosition: _kGooglePlex,

            onTap: (_){

            },
            mapType: MapType.normal,
            markers: Set.of(markers.values),

            onMapCreated: (GoogleMapController controler){
              _controller.complete(controler);

              MarkerId markerId1 = MarkerId("1");
              MarkerId markerId2 = MarkerId("2");
              MarkerId markerId3 = MarkerId("3");

              listMarkerIds.add(markerId1);
              listMarkerIds.add(markerId2);
              listMarkerIds.add(markerId3);


              Marker marker1=Marker(markerId: markerId1,
                  position: LatLng(17.4435, 78.3772),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueCyan),
                  infoWindow: InfoWindow(
                      title: "Hytech City",onTap: (){

                    var  bottomSheetController=Scaffold.of(scaffoldKey.currentContext).
                    showBottomSheet((context) => Container(
                      child:
                      getBottomSheet("17.4435, 78.3772"),
                      height: 250,
                      color: Colors.transparent,
                    ));

                  },snippet: "Snipet Hitech City"
                  ));

              Marker marker2=Marker(markerId: markerId2,
                position: LatLng(17.4837, 78.3158),
                icon:
                BitmapDescriptor.defaultMarkerWithHue
                  (BitmapDescriptor.hueGreen),);
              Marker marker3=
              Marker(markerId:
              markerId3,position:
              LatLng(17.5169, 78.3428),
                  infoWindow: InfoWindow(
                      title: "Miyapur",onTap: (){},snippet: "Miyapur"
                  ));

              setState(() {
                markers[markerId1]=marker1;
                markers[markerId2]=marker2;
                markers[markerId3]=marker3;
              });
            },

          ),
        )
    );
  }

  Widget getBottomSheet(String s)
  {
    return Stack(
      children: [
        Container(

          margin: EdgeInsets.only(top: 32),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: Colors.blueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hytech City Public School \n CBSC",style: TextStyle(
                          color: Colors.white,
                          fontSize: 14
                      ),),
                      SizedBox(height: 5,),
                      Row(children: [

                        Text("4.5",style: TextStyle(
                            color: Colors.white,
                            fontSize: 12
                        )),
                        Icon(Icons.star,color: Colors.yellow,),
                        SizedBox(width: 20,),
                        Text("970 Folowers",style: TextStyle(
                            color: Colors.white,
                            fontSize: 14
                        ))
                      ],),
                      SizedBox(height: 5,),
                      Text("Memorial Park",style: TextStyle(
                          color: Colors.white,
                          fontSize: 14
                      )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [SizedBox(width: 20,),
                  Icon(Icons.map,color: Colors.blue,),
                  SizedBox(width: 20,),Text("$s")],
              ),
              SizedBox(height: 20,),
              Row(
                children: [SizedBox(width: 20,),
                  Icon(Icons.call,color: Colors.blue,),
                  SizedBox(width: 20,),
                  Text("040-123456")],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topRight,

            child: FloatingActionButton(
                child: Icon(Icons.navigation),
                onPressed: (){

                }),
          ),
        )
      ],

    );
  }

}
*/
/*
class DonorMapTab extends StatefulWidget {
  @override
  _DonorMapTabState createState() => _DonorMapTabState();
}

class _DonorMapTabState extends State<DonorMapTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
*/
