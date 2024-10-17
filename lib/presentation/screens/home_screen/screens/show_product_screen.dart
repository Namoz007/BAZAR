import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/product_model.dart';
import '../../../widgets/home_screen_widgets/cart_button.dart';
import '../../../widgets/home_screen_widgets/imgs_scrol_widgets.dart';
import '../../../widgets/home_screen_widgets/product_details.dart';
import '../../../widgets/home_screen_widgets/product_imgs.dart';
import '../products_bloc/products_bloc.dart';
import '../products_bloc/products_bloc_state.dart';

class ShowProductScreen extends StatefulWidget {
  ProductModel product;
  ShowProductScreen({
    super.key,
    required this.product,
  });

  @override
  State<ShowProductScreen> createState() => _ShowProductScreenState();
}

class _ShowProductScreenState extends State<ShowProductScreen> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(widget.product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 238,
              child: ProductImgs(
                imgs: widget.product.imageUrl,
                controller: _pageController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.product.imageUrl.length != 1
                ? ImgsScrolWidgets(
                    length: widget.product.imageUrl.length,
                    controller: _pageController,
                  )
                : const SizedBox(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: BlocBuilder<ProductsBloc, ProductsBlocState>(
                builder: (context, state) {
                  return ProductDetails(
                    product: state is LoadedAllProductsBlocState
                        ? state.products[state.products.indexWhere(
                            (value) => value.id == widget.product.id,
                          )]
                        : widget.product,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.product.quantity == 0
          ? Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: const Text(
                "The product is out of stock",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          : CartButton(
              product: widget.product,
            ),
    );
  }
}
