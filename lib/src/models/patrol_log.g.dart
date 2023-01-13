// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patrol_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatrolLog _$PatrolLogFromJson(Map<String, dynamic> json) => PatrolLog()
  ..route = (json['route'] as List<dynamic>)
      .map((e) => RoutePoint.fromJson(e as Map<String, dynamic>))
      .toList()
  ..incidents = (json['incidents'] as List<dynamic>)
      .map((e) => PatrolIncident.fromJson(e as Map<String, dynamic>))
      .toList()
  ..status = $enumDecode(_$PatrolStatusEnumMap, json['status'])
  ..startTime = json['startTime'] == null
      ? null
      : DateTime.parse(json['startTime'] as String)
  ..endTime = json['endTime'] == null
      ? null
      : DateTime.parse(json['endTime'] as String);

Map<String, dynamic> _$PatrolLogToJson(PatrolLog instance) => <String, dynamic>{
      'route': instance.route,
      'incidents': instance.incidents,
      'status': _$PatrolStatusEnumMap[instance.status]!,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
    };

const _$PatrolStatusEnumMap = {
  PatrolStatus.notStarted: 'notStarted',
  PatrolStatus.inProgress: 'inProgress',
  PatrolStatus.completed: 'completed',
};
