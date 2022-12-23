import 'package:cpnz/src/locations.dart';

class PatrolIncident {
  PatrolIncident(this.lat, this.lng, this.timestamp);

  final double lat;
  final double lng;
  final DateTime timestamp;
  String? description;
  Hotspot? hotspot;
}
