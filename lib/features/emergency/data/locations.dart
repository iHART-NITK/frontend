import 'package:frontend/features/emergency/data/model/location_model.dart';

import '../../../core/network/django_app.dart';

class Location {
  Future<dynamic> getLocations() async {
    final response = await DjangoApp().get('/api/emergency/locations');
    LocationModel m = new LocationModel.secondConst();
    List<LocationModel> x = m.get_location_objects_from_json(response);
    print(x);
  }
}
