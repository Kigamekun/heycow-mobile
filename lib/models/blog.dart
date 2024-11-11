class Blog {
  final int? id;
  final int userId;
  final String? userName;
  final String title;
  final String content;
  final String price;
  final String category;
  final String image;
  final String published;
  final int likesCount;
  final bool isLiked;
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
    required this.price,
    required this.image,
    required this.likesCount,
    required this.isLiked,
    required this.commentsCount,
    required this.published,
    this.publishedAt,
    required this.createdAt,
  });

}
