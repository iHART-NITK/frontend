import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DjangoApp {
  Future<http.Response> get(url, {userSpecific = true}) async {
    var _addr;
    String host = "127.0.0.1";
    String port = "8000";

    int userID = 2;
    String token = "98826630a37d2b6350c78e55d0dc4419f0491069";
    if (userSpecific)
      _addr = Uri.parse('http://$host:$port/user/$userID/$url');
    else
      _addr = Uri.parse('http://$host:$port/$url');
    var response =
        await http.get(_addr, headers: {'Authorization': 'Token $token'});
    debugPrint("[API REQ] $_addr ${response.statusCode}");
    return response;
  }
}
