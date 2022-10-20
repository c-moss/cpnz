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
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _circles.clear();
      for (final office in googleOffices.offices) {
        final circle = Circle(
          circleId: CircleId(office.name),
          radius: 200,
          center: LatLng(office.lat, office.lng),
          fillColor: Color.fromARGB(125, 141, 42, 0),
          strokeColor: Color.fromARGB(255, 141, 42, 0),
          consumeTapEvents: true,
          onTap: () {},
        );
        _circles[office.name] = circle;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Google Office Locations'),
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
