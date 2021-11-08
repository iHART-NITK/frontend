import 'dart:convert';

import 'package:frontend/features/medical_history/data/model/medical_history_model.dart';
import '../../../core/network/django_app.dart';
import 'package:crypto/crypto.dart';
import 'package:hive/hive.dart';

import 'dart:convert' as convert;

class History {
  Future<dynamic> getMed() async {
    final response =
        await DjangoApp().get('/medical-history', userSpecific: true);
    print(response);
    var medicalHash = convert.jsonDecode(response.body) as List<dynamic>;
    HistoryModel m = new HistoryModel();
    dynamic x = m.getLocationObjectsFromJson(medicalHash);
    print(x);
    return x;
  }

  Future<dynamic> getQR() async {
    Hive.openBox('user');
    var box = Hive.box('user');
    var bytes1 = utf8.encode(box.get(0).token);
    var digest1 = sha256.convert(bytes1);
    final response = await DjangoApp()
        .get('/medical-history/html?token=$digest1', userSpecific: true);
    print(response);
    var medicalHash = convert.jsonDecode(response.body) as List<dynamic>;
    HistoryModel m = new HistoryModel();
    dynamic x = m.getLocationObjectsFromJson(medicalHash);
    print(x);
    return x;
  }
}
