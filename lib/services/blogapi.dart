import 'package:flutter/material.dart';
import 'package:frogger/models/blogentry.dart';
import 'package:logger/logger.dart';
import 'package:pocketbase/pocketbase.dart';

enum BlogApiStatus {
  init,
  conAnonym,
  conLogin,
  conError,
}

class BlogApi extends ChangeNotifier {
  late PocketBase _pb;
  BlogApiStatus _status = BlogApiStatus.init;

  BlogApiStatus get status => _status;

  late String userId;
  late String userName;

  final _logger = Logger();

  static const String COL_USERS = "users";
  static const String COL_BLOGS = "blogs";
  static const String COL_LIKES = "likes";
  
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
      final authRecord = await _pb.collection(COL_USERS).authWithPassword(uname, pass);
      userId = authRecord.record!.id;
      userName = authRecord.record!.data['username'];
      _status = BlogApiStatus.conLogin;
      notifyListeners();
      return true;
    } catch (e) {
      _status = BlogApiStatus.conAnonym;
    }
    notifyListeners();
    return false;
  }

  Future<bool> hasLikedBlog(String blogId) async {
    if (_status != BlogApiStatus.conLogin) {
      return Future.error(StateError("Not logged in"));
    }

    try {
      final record = await _pb.collection(COL_LIKES).getFirstListItem('user.id="$userId" && blog.id="$blogId"');
      return true;
    }
    catch (ex) {
      return false;
    }
  }

  // creates a new likes entry for the blog and user if logged in
  // will throw error if not logged in
  Future<RecordModel> likeBlog(String blogId) async {
    if (_status != BlogApiStatus.conLogin) {
      return Future.error(StateError("Not logged in"));
    }

    if (await hasLikedBlog(blogId)) {
      return Future.error(StateError("Already liked"));
    }

    final body = <String, dynamic>{
      "user": userId,
      "blog": blogId
    };

    return await _pb.collection(COL_LIKES).create(body:body);
  }

  // removes likes entry
  unlikeBlog(String blogId) async {
    if (_status != BlogApiStatus.conLogin) {
      return Future.error(StateError("Not logged in"));
    }

    final record = await _pb.collection(COL_LIKES).getFirstListItem('user.id="$userId" && blog.id="$blogId"');

    _logger.d("Found likes entry $record to delete");

    await _pb.collection(COL_LIKES).delete(record.id);
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

    _logger.d("Filtering likes: '$filter'");

    return _pb.collection(COL_LIKES).getFullList(expand: "user,blog", filter: filter.isNotEmpty ? filter  : null);
  }

  // gets list of all blog entries
  Future<List<BlogEntry>> fetchBlogs() async {
    List<BlogEntry> blogs = [];

    final records = await _pb.collection(COL_BLOGS).getFullList(expand: "author");

    final likedRecords = await fetchLikes();

    for (var element in records) { 

      var likes = likedRecords.where((e) => e.expand['blog']?[0].id == element.id).toList();

      // check if we are logged in and if yes if we have liked this blog
      var likedByMe = false;
      if (status == BlogApiStatus.conLogin) {
        likedByMe = likedRecords.any((e) => e.expand['blog']?[0].id == element.id && e.expand['user']?[0].id == userId);
      }

      _logger.d("Blog id ${element.id} has $likes and liked by me $likedByMe");

      blogs.add( BlogEntry.fromRecord( element, likes, likedByMe ) );
    }

    // blogs.forEach((element) { element.addListener(() { updateBlogEntry(element); }); }); // wild and hacky

    return blogs;
  }


  // depending on id will create or update blog entry
  updateBlogEntry(BlogEntry e) async {
    _logger.d("element $e with id ${e.id} updated");

    if (_status != BlogApiStatus.conLogin) {
      throw StateError("Not logged in");
    }

    final body = <String, dynamic>{
      "title": e.title,
      "content": e.content,
      "author": e.author.id
    };

    if (e.id == "") {
      await _pb.collection(COL_BLOGS).create(body: body);
    } else {
      await _pb.collection(COL_BLOGS).update(e.id, body: body);
    }
    
  }

  deleteBlog(String blogId) async {
    if (_status != BlogApiStatus.conLogin) {
      throw StateError("Not logged in");
    }

    await _pb.collection(COL_BLOGS).delete(blogId);
  }

  // clears auth store and logs user out if logged in
  logout() {
    if (_status == BlogApiStatus.conLogin) {
      _pb.authStore.clear();
      _status = BlogApiStatus.conAnonym;
      notifyListeners();
    }
  }

  bool isLoggedIn() {
    return _status == BlogApiStatus.conLogin;
  }
}