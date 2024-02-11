import 'package:frogger/models/blogentry.dart';
import 'package:pocketbase/pocketbase.dart';

enum BlogApiStatus {
  init,
  conAnonym,
  conLogin,
  conError,
}

// singleton to keep logged in
class BlogApi {
  late PocketBase _pb;
  BlogApiStatus _status = BlogApiStatus.init;

  BlogApiStatus get status => _status;

  BlogApi._privateConstructor() {
    try {
      _pb = PocketBase("http://dom.opc6.net:9050");
      _status = BlogApiStatus.conAnonym;
    } catch (e) {
      _status = BlogApiStatus.conError;
    }
  }

  static final BlogApi _instance = BlogApi._privateConstructor();

  factory BlogApi() {
    return _instance;
  }

  // returns true if logged in
  Future<bool> login(String uname, String pass) async {
    try {
      await _pb.collection('users').authWithPassword(uname, pass);
      _status = BlogApiStatus.conLogin;
      return true;
    } catch (e) {
      _status = BlogApiStatus.conAnonym;
    }
    return false;
  }

  Future<List<BlogEntry>> fetchBlogs() async {
    List<BlogEntry> blogs = [];

    final records = await _pb.collection('blogs').getFullList();

    records.forEach((element) { blogs.add( BlogEntry.fromRecord( element ) ); });

    return blogs;
  }
}