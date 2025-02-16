class ReviewModel {
  final String userId;
  final String comment;
  final double rating;

  ReviewModel(
      {required this.userId, required this.comment, required this.rating});

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      userId: map['userId'] ?? '',
      comment: map['comment'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
    );
  }
}
