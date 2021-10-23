import 'dart:convert' as convert;
import 'package:frontend/core/network/django_app.dart';

class FetchNumEmergency {
  Future<int> get() async {
    DjangoApp _djangoGet = new DjangoApp();
    final _response = await _djangoGet.get('/emergency/', userSpecific: true);
    List<dynamic> decodedResponse =
        convert.jsonDecode(_response.body) as List<dynamic>;

    return decodedResponse.length;
  }
}
