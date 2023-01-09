// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutePoint _$RoutePointFromJson(Map<String, dynamic> json) => RoutePoint(
      (json['lat'] as num).toDouble(),
      (json['lng'] as num).toDouble(),
      DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$RoutePointToJson(RoutePoint instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'timestamp': instance.timestamp.toIso8601String(),
    };
