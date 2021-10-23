import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DjangoApp {
  Future<http.Response> get(url, {userSpecific = false}) async {
    var _addr;
    String host = "localhost";
    String port = "3000";
    int userId = 11;

    String token = "2d531831079a434267763ef7132804c89c469cc1";
    if (userSpecific)
      _addr = Uri.parse('http://$host:$port/api/user/$userId$url');
    else
      _addr = Uri.parse('http://$host:$port/api$url');
    var response =
        await http.get(_addr, headers: {'Authorization': 'Token $token'});
    debugPrint("[API REQ] [GET] $_addr ${response.statusCode}");
    return response;
  }

  Future<http.Response> post({url, data}) async {
    var _addr;
    String host = "localhost";
    String port = "3000";

    String token = "2d531831079a434267763ef7132804c89c469cc1";
    _addr = Uri.parse('http://$host:$port/api$url');
    var response = await http.post(_addr,
        headers: {'Authorization': 'Token $token'}, body: data);
    debugPrint("[API REQ] [POST] $_addr ${response.statusCode}");
    return response;
  }
}
