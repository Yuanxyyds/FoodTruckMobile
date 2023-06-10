import 'package:flutter/material.dart';
import 'package:food_truck_mobile/widget/map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../helper/user_location.dart';


/// A [MapScreen] that shows the location of current User
/// TODO: in the future also shows FT's location
class MapScreen extends StatelessWidget {
  const MapScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    UserLocation userLocation = context.watch<UserLocation>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),

      body:FutureBuilder<void>(
        future: userLocation.requestCurrentLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MapWidget(
              currentUserLocation: userLocation.currentUserLocation !=
                  null
                  ? LatLng(
                  userLocation.currentUserLocation!.latitude!,
                  userLocation.currentUserLocation!.longitude!)
                  : const LatLng(43.727707, -79.413954),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
