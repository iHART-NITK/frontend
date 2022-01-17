import 'dart:convert' as convert;
import 'package:crypto/crypto.dart';
import 'package:hive/hive.dart';

import '/core/network/django_app.dart';
import '/features/medical_history/data/model/medical_history_model.dart';

class History {
  Future<dynamic> getMed() async {
    final response =
        await DjangoApp().get('/medical-history/', userSpecific: true);
    var medicalHash = convert.jsonDecode(response.body) as List<dynamic>;
    HistoryModel m = new HistoryModel();
    dynamic x = m.getLocationObjectsFromJson(medicalHash);
    return x;
  }

  Future<dynamic> getQR() async {
    Hive.openBox('user');
    var box = Hive.box('user');
    var bytes1 = convert.utf8.encode(box.get(0).token);
    var digest1 = sha256.convert(bytes1);
    final response = await DjangoApp()
        .get('/medical-history/html?token=$digest1', userSpecific: true);
    var medicalHash = convert.jsonDecode(response.body) as List<dynamic>;
    HistoryModel m = new HistoryModel();
    dynamic x = m.getLocationObjectsFromJson(medicalHash);
    return x;
  }
}
