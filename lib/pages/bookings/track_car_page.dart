import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/lokasi.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:rentalku/services/unit_services.dart';

class TrackCarPage extends StatefulWidget {
  final Unit unit;
  const TrackCarPage({Key? key,required this.unit}) : super(key: key);

  @override
  _TrackCarPageState createState() => _TrackCarPageState(unit);
}

class _TrackCarPageState extends State<TrackCarPage> {
  Marker? _marker;
  late Timer timer;
  final Unit unit;

  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _position = CameraPosition(
    target: LatLng(-7.2974336, 112.7448576),
    zoom: 15,
  );
  double _latitude = -7.2974336;
  double _longitude = 112.7448576;
  String address = "Mencari Lokasi....";
  String plateNumber = "X 1234 XX";
  bool follow = true;

  _TrackCarPageState(this.unit);

  @override
  void initState() {
    setupMarker();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void setupMarker() async {
    _marker = Marker(
      markerId: MarkerId("car"),
      position: LatLng(-7.2974336, 112.7448576),
      infoWindow: InfoWindow(title: unit.name),
      icon: await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(12, 12)),
        "assets/images/car_icon.png",
      ),
    );

    setState(() {});
  }

  Future<void> toCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_latitude, _longitude),
          zoom: await controller.getZoomLevel(),
        ),
      ),
    );
  }

  Future<void> updateLocation() async {
    final GoogleMapController controller = await _controller.future;

    // Simulate change location
    ApiResponse coordinate = await UnitServices.getUnitLocation(unit.id);
    print("init");
    if(coordinate.status){
      print("oke");
      Lokasi data = coordinate.data;
      // print(data.long);
      _latitude = data.lat;
      _longitude = data.long;
    }

    await toAddress(_latitude, _longitude);

    if (_marker != null) {
      setState(() {
        _marker =
            _marker!.copyWith(positionParam: LatLng(_latitude, _longitude));
      });
    }

    if (follow) {
      await toCurrentLocation();
    }
  }

  Future<void> toAddress(double latitude, double longitude) async {
    _latitude = latitude;
    _longitude = longitude;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;

      setState(() {
        address = [
          place.street,
          place.postalCode,
          place.subLocality,
          place.locality,
          place.subAdministrativeArea,
          place.administrativeArea,
        ].join(", ");
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    updateLocation();
    // timer = Timer.periodic(Duration(seconds: 1), (timer) => updateLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Listener(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _position,
              zoomControlsEnabled: false,
              onMapCreated: _onMapCreated,
              markers: Set<Marker>.from([_marker]),
            ),
            onPointerMove: (_) {
              setState(() {
                follow = false;
              });
            },
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Row(
                        children: [
                          Text(
                            "Lacak Kendaraan",
                            style: AppStyle.regular2Text,
                          ),
                          Spacer(),
                          Icon(Icons.history, color: Colors.black, size: 16),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                if (!follow)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      child: FloatingActionButton(
                        onPressed: () {
                          toCurrentLocation();
                          setState(() {
                            follow = true;
                          });
                        },
                        child: Icon(Icons.my_location),
                        backgroundColor: AppColor.green,
                        mini: true,
                      ),
                    ),
                  ),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          unit.nopol,
                          style: AppStyle.regular1Text.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          address,
                          style: AppStyle.regular2Text,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
