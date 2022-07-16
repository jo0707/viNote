import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 1)
class Note extends HiveObject {
  Note(this.title, this.content, this.timestamp);

  @HiveField(0)
  String title;
  @HiveField(1)
  String content;
  @HiveField(2)
  int timestamp;
}