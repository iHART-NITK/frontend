import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DjangoApp {
  Future<http.Response> get(url, {user_specific = true}) async {
    var _addr;
    String host = "localhost";
    String port = "3000";
    int user_id = 2;

    String token = "265bcfe1d1e933e38b00e9c28c4ee42a8e765156";
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
