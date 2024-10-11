class BeritaItem {
  final String id;
  final String title;
  final String link;
  final String seoTitle;
  final String picture;
  final String pictureUrl;
  final String date;
  final String dateId;
  final String hits;
  final String view;
  // for detail
  final String content;
  final String departmentId;

  BeritaItem({
    required this.id,
    required this.title,
    required this.link,
    required this.seoTitle,
    required this.picture,
    required this.pictureUrl,
    required this.date,
    required this.dateId,
    required this.hits,
    required this.view,
    this.content = '',
    this.departmentId = '',
  });
}
