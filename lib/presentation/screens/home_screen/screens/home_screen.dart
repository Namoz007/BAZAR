import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/home_screen_widgets/advertising.dart';
import '../../../widgets/home_screen_widgets/category.dart';
import '../../../widgets/home_screen_widgets/search_detail.dart';
import '../../../widgets/home_screen_widgets/show_products.dart';
import '../products_bloc/products_bloc.dart';
import '../products_bloc/products_bloc_evetn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProductsBloc>().add(
                GetAllProductsFromDataSourcesProductsBlocEvent(
                  type: productCategoryTypes.all,
                ),
              );
        },
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SearchDetail(),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: const Advertising(),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                height: 90,
                width: MediaQuery.of(context).size.width,
                child: const Category(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ShowProducts(),
            ),
            // const ShowProducts()
          ],
        ),
      ),
    );
  }
}
