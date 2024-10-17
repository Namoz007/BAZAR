import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/product_model.dart';
import '../../screens/cart_screen/bloc/cart_bloc/order_bloc.dart';
import '../../screens/cart_screen/bloc/cart_bloc/order_bloc_event.dart';
import '../../screens/cart_screen/bloc/cart_bloc/order_bloc_state.dart';

class CartButton extends StatefulWidget {
  ProductModel product;
  CartButton({super.key,required this.product,});

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 78,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFF40BFFF),
      ),
      alignment: Alignment.center,
      child: BlocBuilder<OrderBloc, OrderBlocState>(
        builder: (context, state) {

          if(state is LoadedAllCardsOrderBlocState){
            int count = 0;
            for(int i = 0;i < state.carts.length;i++){
              if(state.carts[i].product.id == widget.product.id){
                count = state.carts[i].amount;
              }
            }
            return state.carts.any((value) => value.product.id == widget.product.id) ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        if(count != widget.product.quantity){
                          context.read<OrderBloc>().add(AddProductToCartOrderBlocEvent(model: widget.product,),);
                        }
                      },
                      child: const Icon(Icons.add_circle,color: Colors.white,),
                    ), const SizedBox(width: 10,),
                    Text(count.toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,),),

                    const SizedBox(width: 10,),

                    InkWell(
                      onTap: (){
                        context.read<OrderBloc>().add(RemoveProductFromCartOrderBlocEvent(model: widget.product,),);
                      },
                      child: const Icon(Icons.remove_circle,color: Colors.white,),
                    )

                  ],
                ),
                const SizedBox(height: 10,),
                Text("\$${count * widget.product.price}",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16,),)
              ],
            ) :
            InkWell(
              onTap: (){
                context.read<OrderBloc>().add(AddProductToCartOrderBlocEvent(model: widget.product));
              },
              child: const Text("Add To Cart",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,),),
            );
          }

          print(state);

          return const SizedBox();
        },
      ),
    );
  }
}
