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
      await _pb.collection('users').authWithPassword(uname, pass);
      _status = BlogApiStatus.conLogin;
      notifyListeners();
      return true;
    } catch (e) {
      _status = BlogApiStatus.conAnonym;
    }
    notifyListeners();
    return false;
  }

  // gets list of all blog entries
  Future<List<BlogEntry>> fetchBlogs() async {
    List<BlogEntry> blogs = [];

    final records = await _pb.collection('blogs').getFullList();

    for (var element in records) { blogs.add( BlogEntry.fromRecord( element ) ); }

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