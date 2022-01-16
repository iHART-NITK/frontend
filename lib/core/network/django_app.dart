import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class DjangoApp {
  static String host = kIsWeb ? "localhost" : "10.0.2.2";
  static String port = "8000";

  // Function to make GET Requests
  Future<http.Response> get(String url, {bool userSpecific = false}) async {
    Uri _addr;
    Box box = Hive.box('user');

    int userId = box.get(0).id;
    String token = box.get(0).token;

    // If requested resource is user specific, add User ID to URL
    if (userSpecific)
      _addr = Uri.parse('http://$host:$port/api/user/$userId$url');
    else
      _addr = Uri.parse('http://$host:$port/api$url');

    http.Response response =
        await http.get(_addr, headers: {'Authorization': 'Token $token'});

    debugPrint("[API REQ] [GET] $_addr ${response.statusCode}");
    return response;
  }

  // Function to make POST Requests
  Future<http.Response> post(
      {required String url, dynamic data, bool isAnonymous = false}) async {
    Uri _addr = Uri.parse('http://$host:$port/api$url');
    http.Response response;

    if (isAnonymous) {
      response = await http.post(_addr, body: data);
    } else {
      Box box = Hive.box('user');
      response = await http.post(_addr,
          headers: {'Authorization': 'Token ${box.get(0).token}'}, body: data);
    }

    debugPrint("[API REQ] [POST] $_addr ${response.statusCode}");
    return response;
  }
}
