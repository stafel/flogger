import 'package:flutter/material.dart';
import 'package:frogger/models/author.dart';
import 'package:frogger/services/blogapi.dart';
import 'package:pocketbase/pocketbase.dart';

class BlogEntry extends ChangeNotifier {
  //String uuid = const Uuid().v1();
  String id;
  String title;
  String content;
  String creationDate;
  bool liked;
  int totalLikes;
  User author;

  BlogEntry(
      { required this.id,
        required this.title,
      required this.content,
      required this.creationDate,
      required this.liked,
      required this.totalLikes,
      required this.author});

  factory BlogEntry.fromJson(Map<String, dynamic> json) {
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
          creationDate: DateTime.now().toString(),
          liked: false,
          totalLikes: 0,
          author: User(id: "null", username: "null")
        ),
      _ => throw const FormatException('Failed to load blog entry.'),
    };
  }

  factory BlogEntry.fromRecord(RecordModel record, List<RecordModel> likes, bool likedByMe) {

    final author = User.fromRecord(record.expand['author']![0]); // there must be an author

    final date = record.created.split(' ')[0];
    final formatDate = "${date.split('-')[2]}.${date.split('-')[1]}.${date.split('-')[0]}"; // format dd.MM.yyyy

    return BlogEntry(id: record.id, title: record.data['title'], content: record.data['content'], creationDate: formatDate, liked: likedByMe, totalLikes: likes.length, author: author);
  }

  like() {
    liked = true;
    totalLikes++;
    notifyListeners();
  }

  unlike() {
    liked = false;
    totalLikes--;
    notifyListeners();
  }

  toggleLike() {
    if (liked) {
      unlike();
    } else {
      like();
    }
  }
}
