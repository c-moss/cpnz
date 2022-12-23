import 'package:cpnz/src/models/patrol_incident.dart';
import 'package:cpnz/src/models/route_point.dart';

class PatrolLog {
  final List<RoutePoint> route = [];
  final List<PatrolIncident> incidents = [];
  PatrolStatus status = PatrolStatus.notStarted;
}

enum PatrolStatus { notStarted, inProgress, completed }
