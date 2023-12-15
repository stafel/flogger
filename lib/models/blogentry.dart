import 'package:uuid/uuid.dart';

class BlogEntry {
  //String uuid = const Uuid().v1();
  String id;
  String title;
  String content;
  DateTime creationDate;
  bool liked;

  BlogEntry(
      { required this.id,
        required this.title,
      required this.content,
      required this.creationDate,
      required this.liked});

  factory BlogEntry.fromJson(Map<String, dynamic> json) {
    print( json );
    return switch (json) {
      {
        '\$id': String id,
        'title': String title,
        'content': String content,
      } => 
        BlogEntry(
          id: id,
          title: title,
          content: content,
          creationDate: DateTime.now(),
          liked: false,
        ),
      _ => throw const FormatException('Failed to load blog entry.'),
    };
  }
}
