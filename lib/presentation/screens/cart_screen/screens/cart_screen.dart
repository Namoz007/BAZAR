import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/cart_scree_widgets/order_button.dart';
import '../bloc/cart_bloc/order_bloc.dart';
import '../bloc/cart_bloc/order_bloc_event.dart';
import '../bloc/cart_bloc/order_bloc_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(GetAllMyCardsOrderBlocEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your cart!"),
      ),
      body: BlocBuilder<OrderBloc, OrderBlocState>(
        builder: (context, state) {
          if (state is LoadedAllCardsOrderBlocState) {
            return state.carts.isEmpty ? const Center(
              child: Text("Products not available!",style: TextStyle(fontWeight: FontWeight.bold,),),
            ) : ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: state.carts.length,
              itemBuilder: (context, index) {
                final cart = state.carts[index];
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                cart.product.imageUrl[0],
                              ),
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cart.product.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "\$${cart.amount * cart.product.price}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF40BFFF)),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (cart.product.quantity !=
                                          cart.amount) {
                                        context.read<OrderBloc>().add(
                                          AddProductToCartOrderBlocEvent(
                                            model: cart.product,
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                          ),
                                          border: Border.all(
                                            color: Colors.grey,
                                          )),
                                      child: Icon(
                                        Icons.add,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 25,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      cart.amount.toString(),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context.read<OrderBloc>().add(
                                        RemoveProductFromCartOrderBlocEvent(
                                          model: cart.product,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        size: 15,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
      bottomNavigationBar: const OrderButton(),
    );
  }
}
