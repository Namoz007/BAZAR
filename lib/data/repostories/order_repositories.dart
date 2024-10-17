
import '../../core/utils/helpers/dependency_helpers.dart';
import '../datasources/order_sources.dart';
import '../models/order_model.dart';

class OrderRepositories{
  final OrderSources _sources = getIt<OrderSources>();

  Future<void> order(OrderModel model) async{
    await _sources.order(model);
  }

  Future<List<OrderModel>> getMyOrderModel() async{
    return await _sources.getMyOrders();
  }
}