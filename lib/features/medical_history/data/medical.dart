import 'package:frontend/features/medical_history/data/model/medical_history_model.dart';
import '../../../core/network/django_app.dart';
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
}
