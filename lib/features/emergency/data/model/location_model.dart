class LocationModel {
  Map<String, String> get_location_objects_from_json(Map<String, dynamic> j) {
    print(j);
    print(j.runtimeType);
    Map<String, String> locations = new Map();
    j.forEach((key, value) {
      print("${key}: ${value}");
      locations[key] = value;
    });
    print(locations.keys);
    return locations;
  }
}
