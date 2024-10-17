
import '../../data/models/product_model.dart';

class Cart {
  ProductModel product;
  int amount;

  Cart({
    required this.product,
    required this.amount,
  });
}
