import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DjangoApp {
  Future<http.Response> get(url, {user_specific = false}) async {
    var _addr;
    String host = "localhost";
    String port = "3000";
    int user_id = 2;

    String token = "98826630a37d2b6350c78e55d0dc4419f0491069";
    if (user_specific)
      _addr = Uri.parse('http://$host:$port/api/user/$user_id$url');
    else
      _addr = Uri.parse('http://$host:$port/api$url');
    var response =
        await http.get(_addr, headers: {'Authorization': 'Token $token'});
    debugPrint("[API REQ] $_addr ${response.statusCode}");
    return response;
  }
}
