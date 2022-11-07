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
  Future<locations.Locations>? _mapData;

  initState() {
    super.initState();
    _mapData = locations.getMapData();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      List<locations.Hotspot> hotspots = [];
    });
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

    var startPos = regions.isNotEmpty
        ? CameraPosition(
            target: LatLng(regions.first.lat, regions.first.lng),
            zoom: regions.first.zoom)
        : const CameraPosition(target: LatLng(0, 0), zoom: 2);

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: startPos,
      circles: circles.toSet(),
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
}
