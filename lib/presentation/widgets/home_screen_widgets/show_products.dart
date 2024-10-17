import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_bazar/presentation/widgets/home_screen_widgets/show_product_for_menu.dart';
import 'package:online_bazar/presentation/widgets/home_screen_widgets/widget_for_loading_product.dart';

import '../../screens/home_screen/products_bloc/products_bloc.dart';
import '../../screens/home_screen/products_bloc/products_bloc_state.dart';
import '../../screens/home_screen/screens/show_product_screen.dart';

class ShowProducts extends StatefulWidget {
  const ShowProducts({super.key});

  @override
  State<ShowProducts> createState() => _ShowProductsState();
}

class _ShowProductsState extends State<ShowProducts> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsBlocState>(
      builder: (context, state) {
        if (state is LoadingProductsBlocState) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GridView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 15,
              ),
              itemBuilder: (context, state) {
                return const WidgetForLoadingProduct();
              },
            ),
          );
        }

        if (state is LoadedAllProductsBlocState) {
          return state.products.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 150),
                    child: Text("Products not found!"),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: state.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.4,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 15,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowProductScreen(
                                product: state.products[index],
                              ),
                            ),
                          );
                        },
                        child: ShowProductForMenu(
                          product: state.products[index],
                        ),
                      );
                    },
                  ),
                );
        }

        return Container();
      },
    );
  }
}
