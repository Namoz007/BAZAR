
import '../../core/network/dio_network.dart';
import '../models/product_model.dart';
import '../models/review_model.dart';

class ProductsSources {
  final _dio = DioFile.getInstance().dio;

  Future<List<ProductModel>> getAllProducts() async {
    final response = await _dio.get("/products.json");
    if (response.data != null) {
      final mp = response.data as Map<String, dynamic>;
      final lst = mp.keys.toList();
      return [
        for (int i = 0; i < lst.length; i++) ProductModel.fromJson(mp[lst[i]])
      ];
    }
    return [];
  }

  Future<void> createNewProduct(ProductModel product) async {
    final response = await _dio.post(
      "/products.json",
      data: product.toJson(),
    );
    await _dio.patch("/products/${response.data['name']}.json",
        data: {"id": response.data['name']});
  }

  Future<ReviewModel> writeReview(ReviewModel review) async {
    final response = await _dio.post(
        "/products/${review.productId}/reviews.json",
        data: review.toJson());
    await _dio.patch(
      "/products/${review.productId}/reviews/${response.data['name']}.json",
      data: {
        "id": response.data['name'],
      },
    );
    review.id = response.data['name'];
    return review;
  }
}
