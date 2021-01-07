/*
Marker(
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
                    */
