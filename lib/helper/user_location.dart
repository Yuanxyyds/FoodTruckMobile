import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';

class UserLocation extends ChangeNotifier {
  final Location _location = Location();
  LocationData? _currentLocation;

  LocationData? get currentUserLocation => _currentLocation;

  Future<void> requestCurrentLocation() async {
    Location location = Location();
    PermissionStatus permissionStatus;
    try {
      permissionStatus = await location.hasPermission();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error Checking location permission",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
      return;
    }
    if (permissionStatus == PermissionStatus.granted) {
      await _updateLocation();
      return;
    } else {
      Fluttertoast.showToast(
        msg: "No permission",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
      await _requestLocationPermission();
    }
  }

  Future<void> _requestLocationPermission() async {
    Location location = Location();
    PermissionStatus permissionStatus;

    try {
      permissionStatus = await location.requestPermission();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error requesting location permission",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
      return;
    }

    if (permissionStatus == PermissionStatus.granted) {
      await _updateLocation();
    } else {
      Fluttertoast.showToast(
        msg: "Permission not Given",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
      _currentLocation = null;
    }
  }

  Future<void> _updateLocation() async {
    try {
      LocationData location = await _location.getLocation();
      _currentLocation = location;
    }
    catch (e) {
      // Should never get here
      Fluttertoast.showToast(
        msg: "No permission",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
    }
  }
}
