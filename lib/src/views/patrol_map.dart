import 'dart:async';

import 'package:cpnz/src/views/log_incident.dart';
import 'package:cpnz/src/models/patrol_incident.dart';
import 'package:cpnz/src/models/patrol_log.dart';
import 'package:cpnz/src/models/route_point.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:cpnz/src/locations.dart' as locations;
import 'package:geolocator/geolocator.dart';

class PatrolMap extends StatefulWidget {
  const PatrolMap({super.key});

  @override
  State<PatrolMap> createState() => _PatrolMapState();
}

class _PatrolMapState extends State<PatrolMap> {
  Future<locations.Locations>? _mapData;
  final Map<String, Marker> _markers = {};
  final PatrolLog _log = PatrolLog();
  bool _hasGPSFix = false;
  final _logger = Logger();
  StreamSubscription<Position>? _gpsLocationSubscription;

  BitmapDescriptor patrolMarkerIcon = BitmapDescriptor.defaultMarker;

  static const String MARKER_ID_PATROL_CAR = "patrolCar";

  @override
  initState() {
    super.initState();
    _logger.i("CMTEST initState");
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(16, 48)),
            'assets/cpnz_marker.png')
        .then((onValue) {
      patrolMarkerIcon = onValue;
    });
    _mapData = locations.getMapData();
  }

  @override
  dispose() {
    super.dispose();
    _logger.i("CMTEST dispose");
    _gpsLocationSubscription?.cancel();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _logger.i("CMTEST onMapCreated");
    _gpsLocationSubscription = _trackPosition().listen((pos) {
      final latLng = LatLng(pos.latitude, pos.longitude);
      setState(() {
        _hasGPSFix = true;
        _log.route
            .add(RoutePoint(latLng.latitude, latLng.longitude, DateTime.now()));
        _markers["patrolCar"] = Marker(
            markerId: const MarkerId(MARKER_ID_PATROL_CAR),
            position: latLng,
            icon: patrolMarkerIcon);
      });
      controller.animateCamera(CameraUpdate.newLatLng(latLng));
    });
  }

  Widget _buildMap(locations.Locations mapData) {
    var regions = mapData.regions;

    var circles = mapData.hotspots.map((hotspot) => Circle(
          circleId: CircleId(hotspot.name),
          radius: hotspot.radius,
          center: LatLng(hotspot.lat, hotspot.lng),
          fillColor: const Color.fromARGB(125, 235, 83, 33),
          strokeColor: const Color.fromARGB(75, 235, 83, 33),
          strokeWidth: 20,
          consumeTapEvents: true,
          onTap: () {},
        ));

    var startPos = regions.isNotEmpty
        ? CameraPosition(
            target: LatLng(regions.first.lat, regions.first.lng),
            zoom: regions.first.zoom)
        : const CameraPosition(target: LatLng(0, 0), zoom: 2);

    var polyline = Polyline(
      polylineId: const PolylineId('path'),
      points: _log.route.map((e) => LatLng(e.lat, e.lng)).toList(),
      color: Colors.green,
    );

    return GoogleMap(
      onMapCreated: _onMapCreated,
      mapType: MapType.normal,
      initialCameraPosition: startPos,
      circles: circles.toSet(),
      // ignore: prefer_collection_literals
      markers: [
        ..._markers.values,
        ..._log.incidents.map((incident) => Marker(
            markerId: MarkerId(incident.timestamp.toString()),
            position: LatLng(incident.lat, incident.lng)))
      ].toSet(),
      polylines: {polyline},
    );
  }

  @override
  Widget build(BuildContext context) {
    _logger.i("CMTEST build");
    return FutureBuilder(
        future: _mapData,
        builder: (context, AsyncSnapshot<locations.Locations> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                    title: const Text('Patrol Map'),
                    backgroundColor: Colors.green[700],
                    automaticallyImplyLeading: false,
                    actions: [
                      CloseButton(
                        onPressed: () => Navigator.pop(context),
                      )
                    ]),
                body: Stack(children: [
                  _buildMap(snapshot.requireData),
                  if (!_hasGPSFix)
                    Container(
                        alignment: Alignment.center,
                        color: const Color.fromARGB(160, 0, 0, 0),
                        // width: double.infinity,
                        // height: double.infinity,
                        constraints: const BoxConstraints.expand(),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/loading_spinner.gif',
                                width: 70,
                                height: 70,
                              ),
                              const SizedBox(height: 20),
                              const Text("Detecting location..",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20))
                            ]))
                ]),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: _hasGPSFix
                    ? FloatingActionButton.extended(
                        backgroundColor: Colors.orange,
                        icon: const Icon(Icons.report_problem),
                        label: const Text('Log incident'),
                        onPressed: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return LogIncident(
                                    onSubmit: (String? incidentDescription) {
                                  if (incidentDescription != null) {
                                    var currentPosition =
                                        _log.getLatestPosition();
                                    if (currentPosition != null) {
                                      var newIncident =
                                          PatrolIncident.fromRoutePoint(
                                              currentPosition);
                                      newIncident.description =
                                          incidentDescription;
                                      setState(() {
                                        _log.incidents.add(newIncident);
                                      });
                                    }
                                  }
                                  Navigator.pop(context);
                                });
                              });
                        },
                      )
                    : null);
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Loading"),
                automaticallyImplyLeading: false,
              ),
            );
          }
        });
  }

  /// Track the position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Stream` will return an error.
  Stream<Position> _trackPosition() async* {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      throw Exception('Location services are disabled.');
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
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    yield* Geolocator.getPositionStream(
        locationSettings: const LocationSettings(distanceFilter: 5));
  }
}
