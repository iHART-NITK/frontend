import 'dart:convert' as convert;
import '/core/network/django_app.dart';

class FetchNumTransactions {
  Future<int> get() async {
    DjangoApp _djangoGet = new DjangoApp();
    final _response = await _djangoGet.get('/transaction/', userSpecific: true);
    List<dynamic> decodedResponse =
        convert.jsonDecode(_response.body) as List<dynamic>;

    return decodedResponse.length;
  }
}

class FetchAllTransactions {
  Future<int> get() async {
    DjangoApp _djangoGet = new DjangoApp();
    final _response =
        await _djangoGet.get('/transaction/', userSpecific: false);
    List<dynamic> decodedResponse =
        convert.jsonDecode(_response.body) as List<dynamic>;

    return decodedResponse.length;
  }
}
