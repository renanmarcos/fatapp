import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Localização',
      home: Map(),
    );
  }
}

class Map extends StatefulWidget {
  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  static final position = LatLng(-23.6377382, -46.581072117);
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
