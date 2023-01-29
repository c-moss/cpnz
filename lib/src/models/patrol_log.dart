import 'dart:math' show cos, sqrt, asin;

import 'package:cpnz/src/models/patrol_incident.dart';
import 'package:cpnz/src/models/route_point.dart';
import 'package:flutter/foundation.dart';
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

  double getRouteDistanceTravelled() {
    RoutePoint? prev = null;
    return route.fold(0.0, (dist, curr) {
      if (prev != null) {
        dist += _calculateDistance(curr.lat, curr.lng, prev!.lat, prev!.lng);
      }
      prev = curr;
      return dist;
    });
  }

  double _calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}

enum PatrolStatus { notStarted, inProgress, completed }
