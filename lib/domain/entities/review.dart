class Review {
  String id;
  final String userId;
  String userName;
  double score;
  String message;
  final String productId;

  Review({
    required this.id,
    required this.userId,
    required this.score,
    required this.message,
    required this.userName,
    required this.productId,
  });
}
