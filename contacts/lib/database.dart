import 'package:hive/hive.dart';

part 'database.g.dart';

@HiveType(typeId: 0)
class Database {
  @HiveField(0)
  String name;
  @HiveField(1)
  int age;
  @HiveField(2)
  String phone;
  @HiveField(3)
  String email;

  Database(this.name, this.age, this.phone, this.email);
}
