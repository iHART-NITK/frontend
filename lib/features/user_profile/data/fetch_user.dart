import 'dart:convert' as convert;
import '/core/network/django_app.dart';

class FetchUserData {
  Future<Map<String, dynamic>> getData() async {
    DjangoApp _djangoGet = new DjangoApp();
    final _response = await _djangoGet.get('/', userSpecific: true);

    Map<String, dynamic> decodedResponse =
        convert.jsonDecode(_response.body) as Map<String, dynamic>;

    return decodedResponse;
  }
}
