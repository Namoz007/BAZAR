import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/home_screen/products_bloc/products_bloc.dart';
import '../../screens/home_screen/products_bloc/products_bloc_evetn.dart';
import '../../screens/home_screen/products_bloc/products_bloc_state.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(GetAllProductsBlocEvent(type: productCategoryTypes.all));
  }
  
  
  final List<String> _categoryIcons = [
    "grid.png",
    "sneaker.png",
    "trousers.png",
    "backpack.png",
    "cap.png",
    "tracksuit.png",
  ];
  final List<productCategoryTypes> _categoryTypes = [
    productCategoryTypes.all,
    productCategoryTypes.sneaker,
    productCategoryTypes.pants,
    productCategoryTypes.backpack,
    productCategoryTypes.cap,
    productCategoryTypes.tracksuit,
  ];
  final List<String> _categoryNames = [
    "All",
    "Sneakers",
    "Pants",
    "Backpacks",
    "Caps",
    "Tracksuits",
  ];
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsBloc,ProductsBlocState>(
      listener: (context,state){},
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categoryIcons.length,
        itemBuilder: (context, index) {
          return BlocBuilder<ProductsBloc,ProductsBlocState>(
            builder: (context,state){

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      context.read<ProductsBloc>().add(GetAllProductsBlocEvent(type: _categoryTypes[index]));
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue,width: 2),
                        shape: BoxShape.circle,
                        color: (state is LoadedAllProductsBlocState && state.type == _categoryTypes[index]) || (state is LoadingProductsBlocState && state.type == _categoryTypes[index]) ? Colors.blue.shade300 : Colors.white,
                      ),
                      alignment: Alignment.bottomCenter,
                      child: Image.asset('assets/icons/${_categoryIcons[index]}'),
                    ),
                  ),

                  Center(child: Text(_categoryNames[index]),)
                ],
              );
            },
          );
        },
      ),
    );
  }
}
