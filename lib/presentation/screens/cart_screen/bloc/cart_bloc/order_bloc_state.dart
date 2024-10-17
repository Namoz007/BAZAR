
import '../../../../../data/models/cart_model.dart';
import '../../../../../data/models/order_model.dart';

sealed class OrderBlocState {}

final class InitialOrderBlocState extends OrderBlocState {}

final class LoadingOrderBlocState extends OrderBlocState {}

final class LoadedAllCardsOrderBlocState extends OrderBlocState {
  List<CartModel> carts;
  List<OrderModel> orders;

  LoadedAllCardsOrderBlocState({
    required this.carts,
    required this.orders,
  });
}

final class ErrorOrderBlocState extends OrderBlocState {}
