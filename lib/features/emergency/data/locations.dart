import 'dart:convert' as convert;
import 'package:frontend/features/emergency/data/model/location_model.dart';
import '../../../core/network/django_app.dart';

class Location {
  Future<dynamic> getLocations() async {
    final response =
        await DjangoApp().get('/emergency/locations', user_specific: false);
    var location_hash =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    LocationModel m = new LocationModel();
    dynamic x = m.get_location_objects_from_json(location_hash);
    return x;
  }
}
