import 'package:frontend/features/medical_history/data/model/medical_history_model.dart';
import '../../../core/network/django_app.dart';
import 'dart:convert' as convert;

class History {
  Future<dynamic> getMed() async {
    final response = await DjangoApp().get('/medical-history', user_specific: true);
    print(response);
    var medical_hash =
        convert.jsonDecode(response.body) as List<dynamic>;
    HistoryModel m = new HistoryModel();
    dynamic x = m.get_medical_objects_from_json(medical_hash);
    print(x);
    return x;
  }
}