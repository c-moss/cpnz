import 'package:cpnz/src/locations.dart';
import 'package:cpnz/src/models/route_point.dart';

class PatrolIncident {
  PatrolIncident(this.lat, this.lng, this.timestamp);
  PatrolIncident.fromRoutePoint(RoutePoint routePoint)
      : this(routePoint.lat, routePoint.lng, routePoint.timestamp);

  final double lat;
  final double lng;
  final DateTime timestamp;
  String? description;
  Hotspot? hotspot;
}
