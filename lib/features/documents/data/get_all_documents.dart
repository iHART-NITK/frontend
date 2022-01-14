import 'dart:convert' as convert;

import '/core/network/django_app.dart';

class FetchDocuments {
  Future<List<dynamic>> get() async {
    final _response = await DjangoApp().get('/document/');

    List<dynamic> decodedResponse =
        convert.jsonDecode(_response.body) as List<dynamic>;

    return decodedResponse;
  }
}
