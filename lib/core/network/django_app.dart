import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class DjangoApp {
  Future<dynamic> get(url) async {
    var addr = Uri.parse('http://localhost:3000${url}');
    var response = await http.get(addr, headers: {
      'Authorization': 'Token 98826630a37d2b6350c78e55d0dc4419f0491069'
    });
    var resp = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print(resp);
    return (resp);
  }
}
