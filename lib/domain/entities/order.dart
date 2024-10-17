import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../data/models/cart_model.dart';
import '../../presentation/screens/cart_screen/bloc/cart_bloc/order_bloc.dart';

class Order {
  String userId;
  String id;
  List<CartModel> carts;
  double price;
  DateTime dateTime;
  orderActions action;
  Point address;
  String? notificationToken;

  Order({
    required this.userId,
    required this.id,
    required this.carts,
    required this.price,
    required this.dateTime,
    required this.action,
    required this.address,
    this.notificationToken,
  });
}
