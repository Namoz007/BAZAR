
import 'package:online_bazar/domain/entities/review.dart';

import '../../presentation/screens/home_screen/products_bloc/products_bloc.dart';

class Product {
  final String id;
  String name;
  String description;
  int? size;
  final String color;
  double price;
  final List<String> imageUrl;
  int quantity;
  productCategoryTypes category;
  List<Review> reviews;

  Product({
    required this.id,
    required this.name,
    required this.description,
    this.size,
    required this.color,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.category,
    required this.reviews,
  });

}
