import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_truck_mobile/main.dart';
import 'package:food_truck_mobile/widget/dialogs/location_setting_dialog.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// The main UserLocation instance (Provider) that stores the user's location
/// information
class UserLocationProvider extends ChangeNotifier {
  final loc.Location _location = loc.Location();
  String _address = 'Enter your address';
  final String _googleApiKey = 'AIzaSyDGE3bBO-aHvwvIO6_2DgbfSOGF3W3CB50';
  loc.LocationData? _currentLocation;

  loc.LocationData? get currentUserLocation => _currentLocation;

  String get currentAddress => _address;

  /// check the current Location setting, send a request if location disabled
  /// and send an update Location request if location is enabled
  Future<bool> requestCurrentLocation() async {
    PermissionStatus permissionStatus;
    try {
      permissionStatus = await Permission.location.request();
      if (permissionStatus == PermissionStatus.granted) {
        await _updateLocation();
        return true;
      } else {
        _showAlert();
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error Checking location permission",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
      return false;
    }
  }

  /// Update the location
  Future<void> _updateLocation() async {
    try {
      loc.LocationData location = await _location.getLocation();
      _currentLocation = location;
      _address = await _updateAddressFromLocation();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error Updating the location",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
    }
  }

  Future<String> _updateAddressFromLocation() async {
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${currentUserLocation?.latitude},${currentUserLocation?.longitude}&key=$_googleApiKey';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResult = json.decode(response.body);
        if (jsonResult['status'] == 'OK') {
          final results = jsonResult['results'] as List<dynamic>;
          if (results.isNotEmpty) {
            final address = results[0]['formatted_address'];
            return address;
          }
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error Getting the address $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
    }
    return 'Enter your Address';
  }

  void _showAlert() {
    showDialog(
      context: navigatorKey.currentState!.overlay!.context,
      builder: (BuildContext context) {
        return const LocationSettingsDialog();
      },
    );
  }

  Future<List<Map<String, dynamic>>> placeAutoComplete(String query) async {
    Uri uri =
        Uri.https("maps.googleapis.com", "maps/api/place/autocomplete/json", {
      "input": query,
      "key": _googleApiKey,
      "components": "country:ca|country:us",
    });

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        List<dynamic> predictions = jsonResponse['predictions'];
        List<Map<String, dynamic>> autocompleteList = [];

        predictions.forEach((element) {
          String description = element['description'];
          String placeId = element['place_id'];

          autocompleteList.add({
            'description': description,
            'place_id': placeId,
          });
        });

        // Retrieve latitude and longitude for each place
        for (var i = 0; i < autocompleteList.length; i++) {
          String placeId = autocompleteList[i]['place_id'];
          Uri detailsUri =
              Uri.https("maps.googleapis.com", "maps/api/place/details/json", {
            "place_id": placeId,
            "key": _googleApiKey,
          });

          final detailsResponse = await http.get(detailsUri);
          if (detailsResponse.statusCode == 200) {
            final detailsJsonResponse = json.decode(detailsResponse.body);
            double lat =
                detailsJsonResponse['result']['geometry']['location']['lat'];
            double lng =
                detailsJsonResponse['result']['geometry']['location']['lng'];

            autocompleteList[i]['latitude'] = lat;
            autocompleteList[i]['longitude'] = lng;
          }
        }

        return autocompleteList;
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error Getting the address $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
    }

    return [];
  }
}
