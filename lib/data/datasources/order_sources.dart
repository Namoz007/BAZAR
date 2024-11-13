import 'package:firebase_messaging/firebase_messaging.dart';

import '../../core/network/dio_network.dart';
import '../../core/utils/details/app_details.dart';
import '../models/order_model.dart';

class OrderSources {
  final _dio = DioFile.getInstance().dio;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<OrderModel> order(OrderModel order) async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    try{
      String? token = await _firebaseMessaging.getToken();
      order.notificationToken = token;
    }catch(e){
      print("notification token olinmadi");
    }
    final response = await _dio.post(
      "/orders.json",
      data: order.toJson(),
    );
    await _dio.patch(
      "/orders/${response.data['name']}.json",
      data: {"id": response.data['name']},
    );
    order.id = response.data['name'];
    for(int i = 0;i < order.carts.length;i++){
      final data = await _dio.patch("/products/${order.carts[i].product.id}.json",data: {
        'quantity': order.carts[i].product.quantity - order.carts[i].amount,
      });
    }
    return order;
  }

  Future<List<OrderModel>> getMyOrders() async{
    final response = await _dio.get("/orders.json");
    if(response.data != null){
      Map<String,dynamic> mp = response.data;
      List<dynamic> lst = mp.keys.toList();
      return [for(int i = 0;i < lst.length;i++) if(mp[lst[i]]['userId'] == AppDetails.model!.id) OrderModel.fromJson(mp[lst[i]])];
    }
    return [];
  }
}
