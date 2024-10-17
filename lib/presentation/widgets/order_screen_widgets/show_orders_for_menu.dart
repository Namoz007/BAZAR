import 'package:flutter/material.dart';

import '../../../data/models/order_model.dart';
import '../../screens/cart_screen/bloc/cart_bloc/order_bloc.dart';
import 'order_status_actions.dart';

class ShowOrdersForMenu extends StatefulWidget {
  OrderModel orderModel;
  ShowOrdersForMenu({
    super.key,
    required this.orderModel,
  });

  @override
  State<ShowOrdersForMenu> createState() => _ShowOrdersForMenuState();
}

class _ShowOrdersForMenuState extends State<ShowOrdersForMenu> {
  List<orderActions> status = [
    orderActions.ordering,
    orderActions.accepted,
    orderActions.delivering,
    orderActions.delivered,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade400,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.orderModel.dateTime.day}.${widget.orderModel.dateTime.month}.${widget.orderModel.dateTime.year}-year",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "\$${widget.orderModel.price}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.timelapse_sharp,
                color: status.indexWhere(
                            (value) => value == widget.orderModel.action) >=
                        0
                    ? Colors.green
                    : Colors.red,
                size: 40,
              ),
              OrderStatusActions(
                  index: 0,
                  actionIndex: status.indexWhere(
                      (value) => value == widget.orderModel.action)),
              Icon(
                Icons.check_box_outlined,
                color: status.indexWhere(
                            (value) => value == widget.orderModel.action) >=
                        1
                    ? Colors.green
                    : Colors.red,
                size: 40,
              ),
              OrderStatusActions(
                  index: 1,
                  actionIndex: status.indexWhere(
                      (value) => value == widget.orderModel.action)),
              Icon(
                Icons.delivery_dining,
                color: status.indexWhere(
                            (value) => value == widget.orderModel.action) >=
                        2
                    ? Colors.green
                    : Colors.red,
                size: 40,
              ),
              OrderStatusActions(
                  index: 2,
                  actionIndex: status.indexWhere(
                      (value) => value == widget.orderModel.action)),
              Icon(
                Icons.check_box,
                color: status.indexWhere(
                            (value) => value == widget.orderModel.action) >=
                        03
                    ? Colors.green
                    : Colors.red,
                size: 40,
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: widget.orderModel.carts.length,
            itemBuilder: (context, index) {
              final cart = widget.orderModel.carts[index];
              return ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(cart.product.imageUrl[0],),),
                    border: Border.all(color: Colors.grey,),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                title: Text("${cart.amount}x    \$${cart.product.price}"),
              );
            },
          ),
        ],
      ),
    );
  }
}
