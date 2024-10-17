import 'package:bloc/bloc.dart';

import '../../../../../core/utils/details/app_details.dart';
import '../../../../../core/utils/helpers/dependency_helpers.dart';
import '../../../../../data/models/cart_model.dart';
import '../../../../../data/models/order_model.dart';
import '../../../../../data/repostories/order_repositories.dart';
import 'order_bloc_event.dart';
import 'order_bloc_state.dart';

enum orderActions {ordering,accepted,delivering,delivered,cancel}

class OrderBloc extends Bloc<OrderBlocEvent,OrderBlocState>{
  final _repositories = getIt<OrderRepositories>();
  List<CartModel> _carts = [];
  List<OrderModel> _myOrders = [];
  OrderBloc() : super(LoadedAllCardsOrderBlocState(carts: [],orders: [])){
    on<OrderingProductsOrderBlocEvent>(_orderingProducts);
    on<AddProductToCartOrderBlocEvent>(_addProductToCart);
    on<RemoveProductFromCartOrderBlocEvent>(_removeProductFromCart);
    on<GetAllMyOrderBlocEvent>(_getAllMyOrders);
    on<GetAllMyOrdersFromDataBaseOrderBlocEvent>(_getAllMyOrdersFromSources);
    on<GetAllMyCardsOrderBlocEvent>(_getAllMyCards);
  }

  void _getAllMyCards(GetAllMyCardsOrderBlocEvent event,emit){
    emit(LoadedAllCardsOrderBlocState(carts: _carts, orders: _myOrders));
  }

  void _getAllMyOrdersFromSources(GetAllMyOrdersFromDataBaseOrderBlocEvent event,emit) async{
    emit(LoadingOrderBlocState());
    final orders = await _repositories.getMyOrderModel();
    _myOrders = [];
    for(int i = 0;i < orders.length;i++) {
      _myOrders.insert(0, orders[i]);
    }
    emit(LoadedAllCardsOrderBlocState(carts: _carts,orders: _myOrders));
  }

  void _getAllMyOrders(GetAllMyOrderBlocEvent event,emit) async{
    emit(LoadingOrderBlocState());
    if(_myOrders.isEmpty){
      add(GetAllMyOrdersFromDataBaseOrderBlocEvent());
    }else{
      emit(LoadedAllCardsOrderBlocState(carts: _carts, orders: _myOrders));
    }
  }

  void _orderingProducts(OrderingProductsOrderBlocEvent event,emit) async{
    emit(LoadingOrderBlocState());
    double price = 0;
    for(int i = 0;i < _carts.length;i++) {
      price += _carts[i].amount * _carts[i].product.price;
    }
    await _repositories.order(OrderModel(userId: AppDetails.model!.id, id: '', carts: _carts, price: price, dateTime: DateTime.now(), action: orderActions.ordering,address: event.address,),);
    _carts= [];
    emit(LoadedAllCardsOrderBlocState(carts: _carts,orders: _myOrders));
  }

  void _addProductToCart(AddProductToCartOrderBlocEvent event,emit) {
    int index = _carts.indexWhere((value) => value.product.id == event.model.id);
    if(index == -1){
      _carts.add(CartModel(product: event.model, amount: 1,),);
    }else{
      _carts[index].amount+=1;
    }
    emit(LoadedAllCardsOrderBlocState(carts: _carts,orders: _myOrders));
  }

  void _removeProductFromCart(RemoveProductFromCartOrderBlocEvent event,emit){
    int index = _carts.indexWhere((value) => value.product.id == event.model.id);
    if(_carts[index].amount == 1){
      _carts.removeAt(index);
    }else{
      _carts[index].amount -= 1;
    }
    emit(LoadedAllCardsOrderBlocState(carts: _carts,orders: _myOrders));
  }
}