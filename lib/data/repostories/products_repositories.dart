
import '../../core/utils/helpers/dependency_helpers.dart';
import '../datasources/products_sources.dart';
import '../models/product_model.dart';
import '../models/review_model.dart';

class ProductsRepositories{
  final ProductsSources _sources = getIt<ProductsSources>();

  Future<List<ProductModel>> getAllProducts() async{
    return await _sources.getAllProducts();
  }

  Future<void> createNewProduct(ProductModel product) async{
    await _sources.createNewProduct(product);
  }

  Future<ReviewModel> writeReview(ReviewModel review) async{
    return await _sources.writeReview(review);
  }
}