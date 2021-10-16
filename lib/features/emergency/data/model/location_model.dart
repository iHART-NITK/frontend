import 'dart:convert';

class LocationModel {
  String abbr = "";
  String location = "";
  LocationModel(String abbr, String location) {
    this.abbr = abbr;
    this.location = location;
  }
  LocationModel.secondConst() {}

  List<LocationModel> get_location_objects_from_json(Map<String, dynamic> j) {
    print(j.runtimeType);
    print(j);
    Map<String, dynamic> myDecodedJson = j;
    List<LocationModel> locations = new List.empty();
    myDecodedJson.forEach((key, value) {
      locations.add(new LocationModel(key, value));
    });
    return locations;
  }
}
