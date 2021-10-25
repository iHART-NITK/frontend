import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String token;
  @HiveField(2)
  late String type;

  User(int id, String token, String type) {
    this.id = id;
    this.token = token;
    this.type = type;
  }
}
