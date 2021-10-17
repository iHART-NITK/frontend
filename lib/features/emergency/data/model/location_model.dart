import 'dart:convert';

class LocationModel {
  Map<String, String> get_location_objects_from_json(dynamic response) {
    Map<String, String> locations = new Map();
    Map<String, dynamic> j = jsonDecode(response) as Map<String, dynamic>;
    j.forEach((key, value) {
      locations[key] = value;
    });
    return locations;
  }
}
