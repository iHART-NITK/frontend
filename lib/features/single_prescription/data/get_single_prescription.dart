import 'dart:convert' as convert;
import '/core/network/django_app.dart';

class GetSinglePrescription {
  Future<List<dynamic>> getData(num) async {
    DjangoApp _djangoGet = new DjangoApp();
    final _response = await _djangoGet.get('/appointment/$num/prescriptions',
        userSpecific: true);

    List<dynamic> decodedResponse =
        convert.jsonDecode(_response.body) as List<dynamic>;

    return decodedResponse;
  }
}

class GetAppointmentInfo {
  Future<Map<String, dynamic>> getData(num) async {
    DjangoApp _djangoGet = new DjangoApp();
    final _response =
        await _djangoGet.get('/appointment/$num/', userSpecific: false);

    Map<String, dynamic> decodedResponse =
        convert.jsonDecode(_response.body) as Map<String, dynamic>;

    return decodedResponse;
  }
}
