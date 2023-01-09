import 'package:json_annotation/json_annotation.dart';

part 'route_point.g.dart';

@JsonSerializable()
class RoutePoint {
  RoutePoint(this.lat, this.lng, this.timestamp);

  factory RoutePoint.fromJson(Map<String, dynamic> json) =>
      _$RoutePointFromJson(json);
  Map<String, dynamic> toJson() => _$RoutePointToJson(this);

  final double lat;
  final double lng;
  final DateTime timestamp;
}
