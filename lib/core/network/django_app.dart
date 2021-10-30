import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class DjangoApp {
  String host = "10.0.2.2";
  String port = "3000";

  Future<http.Response> get(url, {userSpecific = false}) async {
    var _addr;
    var box = Hive.box('user');

    int userId = box.get(0).id;
    String token = box.get(0).token;
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
    var box = Hive.box('user');

    String token = box.get(0).token;
    _addr = Uri.parse('http://$host:$port/api$url');
    var response = await http.post(_addr,
        headers: {'Authorization': 'Token $token'}, body: data);
    debugPrint("[API REQ] [POST] $_addr ${response.statusCode}");
    return response;
  }

  Future<http.Response> postAnonymous({url, data}) async {
    var _addr;

    _addr = Uri.parse('http://$host:$port/api$url');
    var response = await http.post(_addr, body: data);
    debugPrint("[API REQ] [POST] $_addr ${response.statusCode}");
    return response;
  }
}
