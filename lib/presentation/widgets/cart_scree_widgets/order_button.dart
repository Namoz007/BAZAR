import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/cart_screen/bloc/cart_bloc/order_bloc.dart';
import '../../screens/cart_screen/bloc/cart_bloc/order_bloc_state.dart';
import '../../screens/cart_screen/screens/select_my_location.dart';

class OrderButton extends StatefulWidget {
  const OrderButton({
    super.key,
  });

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc,OrderBlocState>(
      builder: (context, state) {
        if(state is LoadedAllCardsOrderBlocState){
          if(state.carts.isNotEmpty){
            double price = 0;
            for(int i = 0;i < state.carts.length;i++){
              price += state.carts[i].amount * state.carts[i].product.price;
            }
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SelectMyLocation()));
                // context.read<OrderBloc>().add(OrderingProductsOrderBlocEvent());
              },
              child: Container(
                width: double.infinity,
                height: 57,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF40BFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Text(
                  "\$$price",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }else{
            return Container();
          }
        }
        return const SizedBox();
      },
    );
  }
}
