class BlogEntry {
  String title;
  String content;
  DateTime creationDate;
  bool liked;

  BlogEntry(
      {required this.title,
      required this.content,
      required this.creationDate,
      required this.liked});
}
