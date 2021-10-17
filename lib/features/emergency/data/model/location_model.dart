class LocationModel {
  Map<String, String> get_location_objects_from_json(dynamic response) {
    Map<String, String> locations = new Map();
    response.forEach((key, value) {
      locations[key] = value;
    });
    return locations;
  }
}
