class ReviewResultItem {
  final String question;
  final String totalStar;

  ReviewResultItem({
    required this.question,
    required this.totalStar,
  });
}


class ReviewModel {
  final int questionId;
  final int totalStar;

  ReviewModel({required this.questionId, required this.totalStar});
}
