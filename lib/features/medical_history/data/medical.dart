import 'package:frontend/features/medical_history/data/model/medical_history_model.dart';
import '../../../core/network/django_app.dart';

class History {
  Future<dynamic> getMed() async {
    final response = await DjangoApp().get('/api/user/2/medical-history'); 
    print(response);
    HistoryModel m = new HistoryModel();
    dynamic x = m.get_medical_objects_from_json(response);
    print(x);
    return response;
  }
}