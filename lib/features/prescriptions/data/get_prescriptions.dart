import 'dart:convert' as convert;
import 'package:frontend/core/network/django_app.dart';

class GetPrescriptions {
  Future<List<dynamic>> getData() async {
    DjangoApp _djangoGet = new DjangoApp();
    final _response = await _djangoGet.get('/prescription', userSpecific: true);

    List<dynamic> decodedResponse =
        convert.jsonDecode(_response.body) as List<dynamic>;

    print(decodedResponse);
    return decodedResponse;
  }
}
