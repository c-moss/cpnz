import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;
import 'package:geolocator/geolocator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<locations.Locations>? _mapData;
  final Map<String, Marker> _markers = {};
  final List<LatLng> _pathPoints = [];

  initState() {
    super.initState();
    _mapData = locations.getMapData();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _determinePosition().then(
      (position) {
        setState(() {
          _markers.clear();
          final marker = Marker(
            markerId: MarkerId("you"),
            position: LatLng(position.latitude, position.longitude),
          );
          _markers["you"] = marker;
          _pathPoints.add(LatLng(position.latitude, position.longitude));
        });
      },
    );
  }

  Widget _buildMap(locations.Locations mapData) {
    var regions = mapData.regions;

    var circles = mapData.hotspots.map((hotspot) => Circle(
          circleId: CircleId(hotspot.name),
          radius: 200,
          center: LatLng(hotspot.lat, hotspot.lng),
          fillColor: Color.fromARGB(125, 141, 42, 0),
          strokeColor: Color.fromARGB(255, 141, 42, 0),
          consumeTapEvents: true,
          onTap: () {},
        ));

    for (var hotspot in mapData.hotspots) {
      _pathPoints.add(LatLng(hotspot.lat, hotspot.lng));
    }

    var startPos = regions.isNotEmpty
        ? CameraPosition(
            target: LatLng(regions.first.lat, regions.first.lng),
            zoom: regions.first.zoom)
        : const CameraPosition(target: LatLng(0, 0), zoom: 2);

    var polyline = Polyline(
      polylineId: PolylineId('path'),
      points: _pathPoints,
      color: Colors.green,
    );

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: startPos,
      circles: circles.toSet(),
      markers: _markers.values.toSet(),
      polylines: [polyline].toSet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder(
            future: _mapData,
            builder: (context, AsyncSnapshot<locations.Locations> snapshot) {
              if (snapshot.hasData) {
                return Scaffold(
                    appBar: AppBar(
                      title: const Text('Crime Hotspots'),
                      backgroundColor: Colors.green[700],
                    ),
                    body: _buildMap(snapshot.requireData));
              } else {
                return Scaffold(
                  appBar: AppBar(
                    title: Text("Loading"),
                  ),
                );
              }
            }));
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
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
    return await Geolocator.getCurrentPosition();
  }
}
