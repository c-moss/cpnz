import 'package:cpnz/src/models/patrol_incident.dart';
import 'package:cpnz/src/models/route_point.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patrol_log.g.dart';

@JsonSerializable()
class PatrolLog {
  List<RoutePoint> route = [];
  List<PatrolIncident> incidents = [];
  PatrolStatus status = PatrolStatus.notStarted;
  DateTime? startTime;
  DateTime? endTime;

  PatrolLog();

  factory PatrolLog.fromJson(Map<String, dynamic> json) =>
      _$PatrolLogFromJson(json);
  Map<String, dynamic> toJson() => _$PatrolLogToJson(this);

  RoutePoint? getLatestPosition() {
    route.sort(((a, b) => a.timestamp.compareTo(b.timestamp)));
    return route.isNotEmpty ? route.last : null;
  }

  void startPatrol() {
    status = PatrolStatus.inProgress;
    startTime = DateTime.now();
  }

  void endPatrol() {
    status = PatrolStatus.completed;
    endTime = DateTime.now();
  }

  String getStatusString() {
    return status.toString().split(".").last;
  }

  int getRouteDistanceTravelled() {
    return 0;
  }
}

enum PatrolStatus { notStarted, inProgress, completed }
