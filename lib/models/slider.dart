class SliderItem {
  final int id;
  final String title;
  final String type;
  final String picture;
  final String pictureUrl;
  final String createdAt;
  final String updatedAt;

  SliderItem({
    required this.id,
    required this.title,
    required this.type,
    required this.picture,
    required this.pictureUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SliderItem.fromJson(Map<String, dynamic> json) {
    return SliderItem(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      type: json['type'] ?? '',
      picture: json['picture'] ?? '',
      pictureUrl: json['picture_url'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
