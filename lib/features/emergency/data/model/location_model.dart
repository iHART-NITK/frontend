class LocationModel {
  Map<String, String> getLocationObjectsFromJson(dynamic response) {
    Map<String, String> locations = new Map();
    response.forEach((key, value) {
      locations[key] = value;
    });
    return locations;
  }
}
