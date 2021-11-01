import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/core/network/django_app.dart';

void main() {
  group('Django App', () {
    test('host and port name should be correct', () {
      final djangoApp = DjangoApp();
      expect(djangoApp.host, "10.0.2.2");
      expect(djangoApp.port, "3000");
    });
  });
}
