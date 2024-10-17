import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/home_screen_widgets/show_products.dart';
import '../../home_screen/products_bloc/products_bloc.dart';
import '../../home_screen/products_bloc/products_bloc_evetn.dart';
import '../../home_screen/products_bloc/products_bloc_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(SearchProductsBlocEvent(search: ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          onChanged: (value) {
            context
                .read<ProductsBloc>()
                .add(SearchProductsBlocEvent(search: value));
          },
          controller: _searchController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            prefixIcon: const Icon(Icons.search),
            hintText: "Search product",
          ),
        ),
      ),
      body: BlocBuilder<ProductsBloc, ProductsBlocState>(
        builder: (context, state) {
          if (state is LoadedAllProductsBlocState) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ShowProducts(),
            );
          }

          return Container();
        },
      ),
    );
  }
}
