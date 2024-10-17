
import 'package:online_bazar/data/models/product_model.dart';

import '../../domain/entities/cart.dart';

class CartModel extends Cart {
  CartModel({
    required super.product,
    required super.amount,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      product: ProductModel.fromJson(json['product']),
      amount: json['amount'],
    );
  }

  Map<String,dynamic> toJson() {
    return {
      "product": product.toJson(),
      "amount": amount,
    };
  }
}
