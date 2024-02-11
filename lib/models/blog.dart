import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:frogger/models/blogentry.dart';
import 'package:frogger/services/blogapi.dart';

enum BlogState {
  loading,
  done,
  error
}

class Blog extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<BlogEntry> _items = [];

  BlogState _state = BlogState.loading;

  BlogState get state => _state;

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<BlogEntry> get items => UnmodifiableListView(_items);

  /// Adds [item] to blogs. This and [removeAll] are the only ways to modify the
  /// blogs from the outside.
  void add(BlogEntry item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
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

  Blog() {
    BlogApi().fetchBlogs()
      .then((blogs) { _addAll(blogs); })
      .onError((error, stackTrace) { _setState(BlogState.error); });
  }
}
