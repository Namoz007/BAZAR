import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:online_bazar/presentation/screens/home_screen/products_bloc/products_bloc_evetn.dart';
import 'package:online_bazar/presentation/screens/home_screen/products_bloc/products_bloc_state.dart';

import '../../../../core/utils/helpers/dependency_helpers.dart';
import '../../../../data/models/product_model.dart';
import '../../../../data/repostories/products_repositories.dart';

enum productCategoryTypes {
  all,
  tshirt,
  sneaker,
  pants,
  backpack,
  cap,
  tracksuit,
}

class ProductsBloc extends Bloc<ProductsBlocEvent, ProductsBlocState> {
  final _repositories = getIt<ProductsRepositories>();
  List<ProductModel> _products = [];
  ProductsBloc() : super(InitialProductsBlocState()) {
    on<GetAllProductsFromDataSourcesProductsBlocEvent>(
        _getAllProductsFromServices);
    on<GetAllProductsBlocEvent>(_getAllProducts);
    on<CreateNewProductProductsBlocEvent>(_createNewProduct);
    on<WriteReviewForProductsBlocEvent>(_writeReview);
    on<SearchProductsBlocEvent>(_searchProduct);
  }

  void _searchProduct(SearchProductsBlocEvent event, emit) {
    if (event.search.trim().isEmpty) {
      emit(LoadedAllProductsBlocState(
          type: productCategoryTypes.all, products: []));
    } else {
      emit(
          LoadedAllProductsBlocState(type: productCategoryTypes.all, products: [
        for (int i = 0; i < _products.length; i++)
          if (_products[i]
              .name
              .toLowerCase()
              .contains(event.search.toLowerCase()))
            _products[i]
      ]));
    }
  }

  void _writeReview(WriteReviewForProductsBlocEvent event, emit) async {
    final index =
        _products.indexWhere((value) => value.id == event.review.productId);
    _products[index].reviews.add(event.review);
    emit(LoadedAllProductsBlocState(type: event.type, products: _products));
    final response = await _repositories.writeReview(event.review);
    _products[index].reviews.removeWhere((value) =>
        value.userId == response.userId && value.message == response.message);
    _products[index].reviews.add(response);
    emit(LoadedAllProductsBlocState(type: event.type, products: _products));
  }

  void _createNewProduct(CreateNewProductProductsBlocEvent event, emit) async {
    emit(LoadingProductsBlocState(type: event.type));
    await _repositories.createNewProduct(event.product);
    emit(LoadedAllProductsBlocState(type: event.type, products: _products));
  }

  void _getAllProductsFromServices(
      GetAllProductsFromDataSourcesProductsBlocEvent event, emit) async {
    emit(LoadingProductsBlocState(type: event.type));
    _products = await _repositories.getAllProducts();
    emit(LoadedAllProductsBlocState(products: _products, type: event.type));
  }

  void _getAllProducts(GetAllProductsBlocEvent event, emit) async {
    emit(LoadingProductsBlocState(type: event.type));
    if (_products.isEmpty) {
      _products = await _repositories.getAllProducts();
      emit(LoadedAllProductsBlocState(
          products: _sortProductsByType(event.type), type: event.type));
    } else {
      emit(LoadedAllProductsBlocState(
          products: _sortProductsByType(event.type), type: event.type));
    }
  }

  List<ProductModel> _sortProductsByType(productCategoryTypes type) {
    return [
      for (int i = 0; i < _products.length; i++)
        if (_products[i].category == type || type == productCategoryTypes.all)
          _products[i]
    ];
  }
}
