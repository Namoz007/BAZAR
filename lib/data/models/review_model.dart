
import '../../domain/entities/review.dart';

class ReviewModel extends Review {
  ReviewModel({
    required super.id,
    required super.userId,
    required super.score,
    required super.message,
    required super.userName,
    required super.productId,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json,String productId) {
    return ReviewModel(
      id: json['id'],
      productId: productId,
      userId: json['userId'],
      score: double.parse(json['score'].toString()),
      message: json['message'],
      userName: json['userName'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "id": id,
      "userId": userId,
      "score": score,
      "message": message,
      "userName": userName,
    };
  }
}
