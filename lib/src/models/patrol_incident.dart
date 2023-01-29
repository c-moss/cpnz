import 'package:cpnz/src/locations.dart';
import 'package:cpnz/src/models/route_point.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patrol_incident.g.dart';

@JsonSerializable()
class PatrolIncident {
  PatrolIncident(this.lat, this.lng, this.timestamp);
  PatrolIncident.fromRoutePoint(RoutePoint routePoint)
      : this(routePoint.lat, routePoint.lng, routePoint.timestamp);

  factory PatrolIncident.fromJson(Map<String, dynamic> json) =>
      _$PatrolIncidentFromJson(json);
  Map<String, dynamic> toJson() => _$PatrolIncidentToJson(this);

  final double lat;
  final double lng;
  final DateTime timestamp;
  String? description;
  String? location;
  Hotspot? hotspot;
  bool? policeAttended;

  String getIncidentLocationName() {
    final hotspot = this.hotspot;
    final location = this.location;
    if (hotspot != null) {
      return hotspot.name;
    } else if (location != null) {
      return location;
    } else {
      return "$lat, $lng";
    }
  }
}
