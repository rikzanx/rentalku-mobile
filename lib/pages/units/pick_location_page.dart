import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

class PickLocationPage extends StatefulWidget {
  const PickLocationPage({Key? key}) : super(key: key);

  @override
  _PickLocationPageState createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<PickLocationPage> {
  Timer? _debounce;
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _position = CameraPosition(
    target: LatLng(-7.2974336, 112.7448576),
    zoom: 15,
  );
  loc.Location _location = loc.Location();
  TextEditingController _searchTextController = TextEditingController(
    text: "Surabaya",
  );
  double _latitude = -7.2974336;
  double _longitude = 112.7448576;

  @override
  void dispose() {
    if (_debounce != null) _debounce!.cancel();
    super.dispose();
  }

  Future<void> toCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    loc.LocationData location = await _location.getLocation();
    _latitude = location.latitude!;
    _longitude = location.longitude!;

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_latitude, _longitude),
          zoom: 15,
        ),
      ),
    );
  }

  void _onCameraMove(CameraPosition position) {
    if (_debounce != null && _debounce!.isActive) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 1), () {
      toAddress(position.target.latitude, position.target.longitude);
    });
  }

  void toAddress(double latitude, double longitude) async {
    _latitude = latitude;
    _longitude = longitude;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;

      _searchTextController.text = [
        place.street,
        place.postalCode,
        place.subLocality,
        place.locality,
        place.subAdministrativeArea,
        place.administrativeArea,
      ].join(", ");
    }
  }

  void toCoordinate() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    List<Location> locations =
        await locationFromAddress(_searchTextController.text);

    if (locations.isNotEmpty) {
      Location location = locations.first;
      final GoogleMapController controller = await _controller.future;
      _latitude = location.latitude;
      _longitude = location.longitude;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(_latitude, _longitude),
            zoom: 15,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _position,
            zoomControlsEnabled: false,
            onCameraMove: _onCameraMove,
            onMapCreated: _onMapCreated,
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
                      Navigator.pop(context, {
                        'name': _searchTextController.text,
                        'latitude': _latitude,
                        'longitude': _longitude,
                      });
                    },
                  ),
                  Expanded(
                    child: TextFieldWithShadow(
                      hintText: "Cari lokasi",
                      controller: _searchTextController,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: toCoordinate,
                    child: Icon(Icons.search),
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ),
          ),
          Center(
            child: Icon(
              Icons.location_pin,
              color: AppColor.green,
              size: 30,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toCurrentLocation,
        child: Icon(Icons.my_location),
        backgroundColor: AppColor.green,
        mini: true,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    toCurrentLocation();
  }
}
