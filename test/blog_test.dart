import 'package:frogger/models/blog.dart';
import 'package:frogger/models/blogentry.dart';
import 'package:test/test.dart';

void main() {
  group('Testing Blog Provider', () {
    var blog = Blog(api: null);

    test('A new item should be added', () {
      
      var newBlogEntry = BlogEntry(id: "a", title: "test", content: "wow", creationDate: "01.01.2024", liked: false);

      blog.add(newBlogEntry);
      expect(blog.items.contains(newBlogEntry), true);
    });    
  });
}
