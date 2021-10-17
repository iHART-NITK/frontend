import 'dart:convert';
import 'package:http/http.dart';

class LocationModel {
  Map<String, String> get_location_objects_from_json(Response response) {
    print(response);
    print(response.runtimeType);
    Map<String, String> locations = new Map();
    Map<String, dynamic> j = jsonDecode(response.body) as Map<String, dynamic>;
    j.forEach((key, value) {
      print("${key}: ${value}");
      locations[key] = value;
    });
    print(locations.keys);
    return locations;
  }
}
