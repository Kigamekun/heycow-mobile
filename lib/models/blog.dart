class Blog {
  final int? id;
  final int userId;
  final String? userName;
  final String title;
  final String content;
  final String category;
  final String image;
  final String published;
  final int likesCount;
  final int commentsCount;

  final String? publishedAt;
  final DateTime createdAt;

  Blog({
    this.id,
    required this.userId,
    this.userName,
    required this.title,
    required this.content,
    required this.category,
    required this.image,
    required this.likesCount,
    required this.commentsCount,
    required this.published,
    this.publishedAt,
    required this.createdAt,
  });

}
