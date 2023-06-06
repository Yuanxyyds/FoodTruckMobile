import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;


class MapWidget extends StatefulWidget {
  const MapWidget({
    super.key,
    this.isFixed = false,
    required this.currentUserLocation,
  });

  final bool isFixed;
  final LatLng currentUserLocation;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller = Completer();
  List<Map<String, dynamic>> data = <Map<String, dynamic>>[];
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  final Set<Marker> _usersMarkers = Set<Marker>();
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    data.add(
      {
        'id': '1',
        'globalKey': GlobalKey(),
        'position': widget.currentUserLocation,
        'widget': const Center(
          child: CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('images/UnknownUser.jpg'),
          ),
        ),
      },
    );
    data.add({
      'id': '1',
      'globalKey': GlobalKey(),
      'position': LatLng(widget.currentUserLocation.latitude! + 0.005,
          widget.currentUserLocation.longitude! + 0.005),
      'widget': const Center(
        child: CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('images/UnknownUser.jpg'),
        ),
      ),
    }
    );
    WidgetsBinding.instance?.addPostFrameCallback((_) => _onBuildCompleted());
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded
        ? GoogleMap(
            myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(
                target: widget.currentUserLocation,
                zoom: 14),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _usersMarkers,
          )
        : ListView(
            children: [
              for (int i = 0; i < data.length; i++)
                Transform.translate(
                  offset: Offset(
                    -MediaQuery.of(context).size.width * 2,
                    -MediaQuery.of(context).size.height * 2,
                  ),
                  child: RepaintBoundary(
                    key: data[i]['globalKey'],
                    child: data[i]['widget'],
                  ),
                )
            ],
          );
  }

  Future<void> _onBuildCompleted() async {
    await Future.wait(
      data.map((value) async {
        Marker marker = await _generateMarkersFromWidgets(value);
        _usersMarkers.add(marker);
      }),
    );
     setState(() {
      _isLoaded = true;
    });
  }

  Future<Marker> _generateMarkersFromWidgets(Map<String, dynamic> data) async {
    BuildContext? context = data['globalKey'].currentContext;
    RenderRepaintBoundary boundary =
        context?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 2);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return Marker(
      markerId: MarkerId(data['id']),
      position: data['position'] as LatLng,
      icon: BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List()),
    );
  }



}
