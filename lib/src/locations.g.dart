// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      id: json['id'] as String,
      name: json['name'] as String,
      zoom: (json['zoom'] as num).toDouble(),
    );

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'id': instance.id,
      'name': instance.name,
      'zoom': instance.zoom,
    };

Hotspot _$HotspotFromJson(Map<String, dynamic> json) => Hotspot(
      address: json['address'] as String?,
      id: json['id'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      radius: (json['radius'] as num).toDouble(),
      name: json['name'] as String,
      description: json['description'] as String,
      region: json['region'] as String,
    );

Map<String, dynamic> _$HotspotToJson(Hotspot instance) => <String, dynamic>{
      'address': instance.address,
      'id': instance.id,
      'lat': instance.lat,
      'lng': instance.lng,
      'radius': instance.radius,
      'name': instance.name,
      'description': instance.description,
      'region': instance.region,
    };

Locations _$LocationsFromJson(Map<String, dynamic> json) => Locations(
      hotspots: (json['hotspots'] as List<dynamic>)
          .map((e) => Hotspot.fromJson(e as Map<String, dynamic>))
          .toList(),
      regions: (json['regions'] as List<dynamic>)
          .map((e) => Region.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'hotspots': instance.hotspots,
      'regions': instance.regions,
    };
