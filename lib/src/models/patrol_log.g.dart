// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patrol_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatrolLog _$PatrolLogFromJson(Map<String, dynamic> json) =>
    PatrolLog()..status = $enumDecode(_$PatrolStatusEnumMap, json['status']);

Map<String, dynamic> _$PatrolLogToJson(PatrolLog instance) => <String, dynamic>{
      'status': _$PatrolStatusEnumMap[instance.status]!,
    };

const _$PatrolStatusEnumMap = {
  PatrolStatus.notStarted: 'notStarted',
  PatrolStatus.inProgress: 'inProgress',
  PatrolStatus.completed: 'completed',
};
