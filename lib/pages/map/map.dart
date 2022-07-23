import 'dart:async';

import 'package:e_shelter/providers/users-provider.dart';
import 'package:e_shelter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({Key? key}) : super(key: key);

  @override
  State<GoogleMapWidget> createState() => GoogleMapWidgetState();
}

class GoogleMapWidgetState extends State<GoogleMapWidget> {
  late GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  late bool serviceEnabled;
  late LocationPermission permission;
  late Position? position;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    // print(position);

    // final googleOffices = await locations.getGoogleOffices();
    // setState(() {
    //   _markers.clear();
    //   for (final office in googleOffices.offices) {
    //     final marker = Marker(
    //       markerId: MarkerId("Refuge"),
    //       position: LatLng(position.latitude, position.longitude),
    //       infoWindow: InfoWindow(
    //         title: "Refuge",
    //         snippet: office.address,
    //       ),
    //     );
    //     _markers[office.name] = marker;
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final userInfoProvider = Provider.of<UserInfoProvider>(context);
    position = userInfoProvider.userInfo["additionalInfo"]["location"];
    Future<Position> _determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    }

    Future<void> getMyLocation() async {
      position = await _determinePosition();

      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position!.latitude, position!.longitude),
        zoom: 13.0,
      )));

      final marker = Marker(
        markerId: MarkerId("Refuge"),
        position: LatLng(position!.latitude, position!.longitude),
        infoWindow: const InfoWindow(
          title: "Refuge",
          // snippet: office.address,
        ),
      );
      _markers["Refuge"] = marker;
    }

    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: position != null
              ? LatLng(position!.latitude, position!.longitude)
              : _center,
          zoom: 13.0,
        ),
        markers: _markers.values.toSet(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        onPressed: getMyLocation,
        backgroundColor: primaryColorDark,
        child: Icon(
          FontAwesomeIcons.locationCrosshairs,
          color: secondaryColor,
        ),
      ),
    );
  }
}
