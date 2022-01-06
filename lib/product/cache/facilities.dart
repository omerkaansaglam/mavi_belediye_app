import 'package:hive/hive.dart';

part 'facilities.g.dart';

@HiveType(typeId: 1)
class Facilities {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  bool isFavorited;

  Facilities({required this.id, required this.title, required this.isFavorited});
}
