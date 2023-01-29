// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patrol_incident.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatrolIncident _$PatrolIncidentFromJson(Map<String, dynamic> json) =>
    PatrolIncident(
      (json['lat'] as num).toDouble(),
      (json['lng'] as num).toDouble(),
      DateTime.parse(json['timestamp'] as String),
    )
      ..description = json['description'] as String?
      ..location = json['location'] as String?
      ..hotspot = json['hotspot'] == null
          ? null
          : Hotspot.fromJson(json['hotspot'] as Map<String, dynamic>)
      ..policeAttended = json['policeAttended'] as bool?;

Map<String, dynamic> _$PatrolIncidentToJson(PatrolIncident instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'timestamp': instance.timestamp.toIso8601String(),
      'description': instance.description,
      'location': instance.location,
      'hotspot': instance.hotspot,
      'policeAttended': instance.policeAttended,
    };
