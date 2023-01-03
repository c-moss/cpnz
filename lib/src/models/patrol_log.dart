import 'package:cpnz/src/models/patrol_incident.dart';
import 'package:cpnz/src/models/route_point.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PatrolLog {
  final List<RoutePoint> route = [];
  final List<PatrolIncident> incidents = [];
  PatrolStatus status = PatrolStatus.notStarted;

  RoutePoint? getLatestPosition() {
    route.sort(((a, b) => a.timestamp.compareTo(b.timestamp)));
    return route.isNotEmpty ? route.last : null;
  }
}

enum PatrolStatus { notStarted, inProgress, completed }
