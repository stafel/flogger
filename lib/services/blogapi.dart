import 'package:flutter/material.dart';
import 'package:frogger/models/blogentry.dart';
import 'package:pocketbase/pocketbase.dart';

enum BlogApiStatus {
  init,
  conAnonym,
  conLogin,
  conError,
}

// singleton to keep logged in
class BlogApi extends ChangeNotifier {
  late PocketBase _pb;
  BlogApiStatus _status = BlogApiStatus.init;

  BlogApiStatus get status => _status;

  late String userId;

  /*
  // singleton
  BlogApi._privateConstructor() {
    try {
      _pb = PocketBase("http://dom.opc6.net:9050");
      _status = BlogApiStatus.conAnonym;
    } catch (e) {
      _status = BlogApiStatus.conError;
    }
    notifyListeners();
  }

  static final BlogApi _instance = BlogApi._privateConstructor();

  factory BlogApi() {
    return _instance;
  }
  */
  
  // normal class constructor
  BlogApi() {
    try {
      _pb = PocketBase("http://dom.opc6.net:9050");
      _status = BlogApiStatus.conAnonym;
    } catch (e) {
      _status = BlogApiStatus.conError;
    }
    notifyListeners();
  }
  

  // trys to log in, returns true if logged in
  Future<bool> login(String uname, String pass) async {
    try {
      final authRecord = await _pb.collection('users').authWithPassword(uname, pass);
      userId = authRecord.record!.id;
      _status = BlogApiStatus.conLogin;
      notifyListeners();
      return true;
    } catch (e) {
      _status = BlogApiStatus.conAnonym;
    }
    notifyListeners();
    return false;
  }

  // returns all likes entries, can have filter
  Future<List<RecordModel>> fetchLikes([String? userId, String? blogId]) {

    String filter = "";

    if (userId != null) {
      filter = "user.id = \"$userId\"";
    }

    if (blogId != null) {
      if (filter.isNotEmpty) {
        filter += " && ";
      }
      filter += "blog.id = \"$blogId\"";
    }

    print("Filtering: '$filter'");

    return _pb.collection('likes').getFullList(expand: "user,blog", filter: filter.isNotEmpty ? filter  : null);
  }

  // gets list of all blog entries
  Future<List<BlogEntry>> fetchBlogs() async {
    List<BlogEntry> blogs = [];

    final records = await _pb.collection('blogs').getFullList(expand: "author");

    final likedRecords = await fetchLikes();

    for (var element in records) { 

      var likes = likedRecords.where((e) => e.expand['blog']?[0].data['id'] == element.id).toList();

      // check if we are logged in and if yes if we have liked this blog
      var likedByMe = false;
      if (status == BlogApiStatus.conLogin) {
        likedRecords.any((e) => e.expand['blog']?[0].data['id'] == element.id && e.expand['user']?[0].data['id'] == userId);
      }

      blogs.add( BlogEntry.fromRecord( element, likes, likedByMe ) );
    }

    return blogs;
  }

  // clears auth store and logs user out if logged in
  logout() {
    if (_status == BlogApiStatus.conLogin) {
      _pb.authStore.clear();
      _status = BlogApiStatus.conAnonym;
      notifyListeners();
    }
  }
}