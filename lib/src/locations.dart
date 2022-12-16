import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

@JsonSerializable()
class Region {
  Region({
    required this.lat,
    required this.lng,
    required this.id,
    required this.name,
    required this.zoom,
  });

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  Map<String, dynamic> toJson() => _$RegionToJson(this);

  final double lat;
  final double lng;
  final String id;
  final String name;
  final double zoom;
}

@JsonSerializable()
class Hotspot {
  Hotspot({
    this.address,
    required this.id,
    required this.lat,
    required this.lng,
    required this.radius,
    required this.name,
    required this.description,
    required this.region,
  });

  factory Hotspot.fromJson(Map<String, dynamic> json) =>
      _$HotspotFromJson(json);
  Map<String, dynamic> toJson() => _$HotspotToJson(this);

  final String? address;
  final String id;
  final double lat;
  final double lng;
  final double radius;
  final String name;
  final String description;
  final String region;
}

@JsonSerializable()
class Locations {
  Locations({
    required this.hotspots,
    required this.regions,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Hotspot> hotspots;
  final List<Region> regions;
}

Future<Locations> getMapData() async {
  const googleLocationsURL = 'https://about.google/static/data/locations.json';

  // Retrieve the locations of Google offices
  try {
    final response = await http.get(Uri.parse(googleLocationsURL));
    if (response.statusCode == 200) {
      return Locations.fromJson(
          //json.decode(response.body) as Map<String, dynamic>);
          //Return static location data until we have a server...
          json.decode(
        await rootBundle.loadString('assets/locations.json'),
      ) as Map<String, dynamic>);
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }

  // Fallback for when the above HTTP request fails.
  return Locations.fromJson(
    json.decode(
      await rootBundle.loadString('assets/locations.json'),
    ) as Map<String, dynamic>,
  );
}
