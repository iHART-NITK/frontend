import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class DjangoApp {
  Future<dynamic> get(url) async {
    var addr = Uri.parse('http://localhost:3000${url}');
    var response = await http.get(addr, headers: {
      'Authorization': 'Token 265bcfe1d1e933e38b00e9c28c4ee42a8e765156'
    });
    var resp = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print(resp);
    return (resp);
  }
}
