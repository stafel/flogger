import 'dart:convert';

import 'package:frogger/models/blogentry.dart';
import 'package:http/http.dart' as http;

class OldBlogApi {
  static String baseUrl = 'https://cloud.appwrite.io/v1/databases/blog-db';

  static Map<String, String> headers = {'X-Appwrite-Project': '6568509f75ac404ff6ae', 'X-Appwrite-Key': 'ac0f362d0cf82fe3d138195e142c0a87a88cee4e2c48821192fb307e1a1c74ee694246f90082b4441aa98a2edaddead28ed6d18cf08c4de0df90dcaeeb53d14f14fb9eeb2edec6708c9553434f1d8df8f8acbfbefd35cccb70f2ab0f9a334dfd979b6052f6e8b8610d57465cbe8d71a7f65e8d48aede789eef6b976b1fe9b2e2'};

  Future<List<BlogEntry>> fetchBlogs() async {
    final response = await http.get(Uri.parse('$baseUrl/collections/blogs/documents'), headers: headers);

    if (response.statusCode == 200) {
      var jobj = jsonDecode(response.body);

      List<BlogEntry> blogs = [];
      for (final x in jobj['documents']) {
        blogs.add(BlogEntry.fromJson(x as Map<String, dynamic>));
      }
      return blogs;
      
    } else {
      throw Exception('Failed to reach endpoint');
    }
  }
}