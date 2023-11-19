import 'package:uuid/uuid.dart';

class BlogEntry {
  String uuid = const Uuid().v1();
  String title;
  String content;
  DateTime creationDate;
  bool liked;

  BlogEntry(
      {required this.title,
      required this.content,
      required this.creationDate,
      required this.liked});
}
