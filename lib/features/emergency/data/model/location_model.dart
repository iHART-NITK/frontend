class LocationModel {
  Map<String, String> get_location_objects_from_json(Map<String, dynamic> j) {
    Map<String, String> locations = new Map();
    j.forEach((key, value) {
      locations[key] = value;
    });
    return locations;
  }
}
