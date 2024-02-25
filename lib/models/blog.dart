import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:frogger/models/author.dart';
import 'package:frogger/models/blogentry.dart';
import 'package:frogger/services/blogapi.dart';
import 'package:intl/intl.dart';

enum BlogState {
  loading,
  done,
  error
}

class Blog extends ChangeNotifier {
  /// Internal, private state of the blog.
  final List<BlogEntry> _items = [];

  BlogState _state = BlogState.loading;

  BlogState get state => _state;

  /// An unmodifiable view of the items in the blog.
  UnmodifiableListView<BlogEntry> get items => UnmodifiableListView(_items);

  final BlogApi? api; // reference to the pb blog api

  /// Adds [item] to blogs. This and [removeAll] are the only ways to modify the
  /// blogs from the outside.
  void add(BlogEntry item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the blog.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void _addAll(Iterable<BlogEntry> i) {
    _items.addAll(i);
    _state = BlogState.done;
    notifyListeners();
  }

  void _setState(BlogState s) {
    _state = s;
     notifyListeners();
  }

  Blog({this.api}) {
    if (api != null) {

      api!.addListener(() { updateFromPocketbase(); });

      updateFromPocketbase();
    }
  }

  // reloads bloglist from pocketbase
  updateFromPocketbase() {
    _state = BlogState.loading;
    removeAll();

    api!.fetchBlogs()
      .then((blogs) { _addAll(blogs); })
      .onError((error, stackTrace) { _setState(BlogState.error); });
  }

  BlogEntry? getById(String id) {
    return items.where((element) => element.id == id).firstOrNull;
  }

  likeBlog(String blogId) {
    api?.likeBlog(blogId);
    notifyListeners();
  }

  unlikeBlog(String blogId) {
    api?.unlikeBlog(blogId);
    notifyListeners();
  }

  createBlogSimple(String title, String content) {
    String formattedDate = DateFormat('dd.MM.yyyy').format(DateTime.now());

    User user = User(id: api?.userId ?? "testid", username: api?.userName ?? "anon");

    final newEntry = BlogEntry(id: "", title: title, content: content, creationDate: formattedDate, liked: false, totalLikes: 0, author: user);

    createBlog(newEntry);
  }

  createBlog(BlogEntry entry) {
    api?.updateBlogEntry(entry);
    add(entry);
  }

  updateBlogSimple(String blogId, String title, String content) {

    var blogentry = getById(blogId)!;

    blogentry.title = title;
    blogentry.content = content;

    updateBlog(blogentry);
  }

  updateBlog(BlogEntry entry) {
    api?.updateBlogEntry(entry);
    final index = _items.indexWhere((element) => element.id == entry.id);
    _items.removeAt(index);
    _items.insert(index, entry);
    notifyListeners();
  }
}
