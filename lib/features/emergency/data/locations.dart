import 'dart:convert' as convert;

import '/features/emergency/data/model/location_model.dart';
import '/core/network/django_app.dart';

class Location {
  Future<Map<String, String>> getLocations() async {
    final response =
        await DjangoApp().get('/emergency/locations/', userSpecific: false);
    var locationHash =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    LocationModel m = new LocationModel();
    Map<String, String> x = m.getLocationObjectsFromJson(locationHash);
    return x;
  }
}
