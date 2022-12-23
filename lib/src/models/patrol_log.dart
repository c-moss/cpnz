import 'package:cpnz/src/models/patrol_incident.dart';
import 'package:cpnz/src/models/route_point.dart';

class PatrolLog {
  final List<RoutePoint> route = List.empty();
  final List<PatrolIncident> incidents = List.empty();
  PatrolStatus status = PatrolStatus.notStarted;
}

enum PatrolStatus { notStarted, inProgress, completed }
