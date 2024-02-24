import 'package:pocketbase/pocketbase.dart';

class User {
  String id;
  String username;

  User({required this.id, required this.username});

  factory User.fromRecord(RecordModel record) {
    return User(id: record.id, username: record.data['username']);
  }
}