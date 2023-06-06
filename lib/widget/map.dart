import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key, this.currentUserLocation});

  final LocationData? currentUserLocation;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  LatLng? _currentUserPosition;
  final Set<Marker> _usersMarkers = Set<Marker>();

  @override
  void initState() {
    super.initState();
    _currentUserPosition = widget.currentUserLocation != null
        ? LatLng(widget.currentUserLocation!.latitude!,
            widget.currentUserLocation!.longitude!)
        : const LatLng(44, -79.8);
    _addUsersMarker(_currentUserPosition!, 'Current User');
  }

  void _addUsersMarker(LatLng position, String title) {
    final markerId = MarkerId(title);
    final marker = Marker(
      markerId: markerId,
      position: position,
      infoWindow: InfoWindow(title: title),
    );
    setState(() {
      _usersMarkers.add(marker);
    });
  }



  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      scrollGesturesEnabled: false,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: false,
      initialCameraPosition: CameraPosition(
        target: _currentUserPosition!,
        zoom: 13.0,
      ),
      markers: _usersMarkers,
    );
  }
}
