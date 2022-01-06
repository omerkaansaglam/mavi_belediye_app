import 'package:hive/hive.dart';

part 'announcements.g.dart';

@HiveType(typeId: 2)
class Announcements {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  Announcements({required this.id, required this.title, required this.description});
}
