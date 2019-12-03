import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Localização"),
        backgroundColor: const Color(0xFFCE0000),
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      body: Map(),
    );
  }
}

class Map extends StatefulWidget {
  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  static final position = LatLng(-23.637119, -46.578780);
  static final CameraPosition _myLocation =
      CameraPosition(target: position, zoom: 15);
  final Set<Marker> _markers = new Set();

  @override
  Widget build(BuildContext context) {
    _markers.add(Marker(
      markerId: MarkerId(position.toString()),
      position: position,
      infoWindow: InfoWindow(title: 'Fatec São Caetano do Sul'),
      icon: BitmapDescriptor.defaultMarker,
    ));

    return new Scaffold(
      body: GoogleMap(
          mapToolbarEnabled: true,
          zoomGesturesEnabled: true,
          markers: _markers,
          initialCameraPosition: _myLocation,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          }),
    );
  }
}
