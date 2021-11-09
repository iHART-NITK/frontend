import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/core/network/django_app.dart';

void main() {
  group('Django App', () {
    test('host and port name should be correct', () {
      expect(DjangoApp.host, "10.0.2.2");
      expect(DjangoApp.port, "3000");
    });
  });
}
