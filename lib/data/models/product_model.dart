import 'package:online_bazar/data/models/review_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../domain/entities/product.dart';
import '../../presentation/screens/home_screen/products_bloc/products_bloc.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.description,
    super.size,
    required super.color,
    required super.price,
    required super.imageUrl,
    required super.quantity,
    required super.category,
    required super.reviews,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    Map<String,productCategoryTypes> mp = {
      "sneaker": productCategoryTypes.sneaker,
      "all": productCategoryTypes.all,
      "tshirt": productCategoryTypes.tshirt,
      "pants": productCategoryTypes.pants,
      "backpack": productCategoryTypes.backpack,
      "cap": productCategoryTypes.cap,
      "tracksuit": productCategoryTypes.tracksuit,
    };
    bool isList = json['reviews'].runtimeType == List<dynamic>;

    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      size: json['size'],
      color: json['color'],
      price: json['price'].toDouble(),
      imageUrl: [for(int i = 0;i < json['imageUrl'].length;i++) json['imageUrl'][i]],
      quantity: json['quantity'],
      category: mp["${json['category']}"]!,
      reviews: json['reviews'] == null ? [] : isList ? [for(int i = 0;i < json['reviews'].length;i++) ReviewModel.fromJson(json['reviews'][i], json['id'])] : [for(int i = 0;i < json['reviews'].keys.toList().length;i++) ReviewModel.fromJson(json['reviews'][json['reviews'].keys.toList()[i]], json["id"])],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'size': size,
      'color': color,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'category': category.name,
      "reviews": reviews,
    };
  }
}
