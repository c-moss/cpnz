import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, Circle> _circles = {};
  late final locations.Locations _mapData;
  Future<void> _onMapCreated(GoogleMapController controller) async {
    _mapData = await locations.getMapData();
    setState(() {
      _circles.clear();
      for (final hotspot in _mapData.hotspots) {
        final circle = Circle(
          circleId: CircleId(hotspot.name),
          radius: 200,
          center: LatLng(hotspot.lat, hotspot.lng),
          fillColor: Color.fromARGB(125, 141, 42, 0),
          strokeColor: Color.fromARGB(255, 141, 42, 0),
          consumeTapEvents: true,
          onTap: () {},
        );
        _circles[hotspot.name] = circle;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Crime Hotspots'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0),
            zoom: 2,
          ),
          circles: _circles.values.toSet(),
        ),
      ),
    );
  }
}
