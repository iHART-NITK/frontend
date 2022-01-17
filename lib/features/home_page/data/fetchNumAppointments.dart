import 'dart:convert' as convert;
import '/core/network/django_app.dart';

class FetchNumAppointments {
  Future<int> get() async {
    DjangoApp _djangoGet = new DjangoApp();
    final _response = await _djangoGet.get('/appointment/', userSpecific: true);
    List<dynamic> decodedResponse =
        convert.jsonDecode(_response.body) as List<dynamic>;

    return decodedResponse.length;
  }
}

class FetchAllAppointments {
  Future<int> get() async {
    DjangoApp _djangoGet = new DjangoApp();
    final _response =
        await _djangoGet.get('/appointment/', userSpecific: false);
    List<dynamic> decodedResponse =
        convert.jsonDecode(_response.body) as List<dynamic>;

    return decodedResponse.length;
  }
}
