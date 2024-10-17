import 'package:flutter/material.dart';


class OrderStatusActions extends StatefulWidget {
  int index;
  int actionIndex;
  OrderStatusActions({super.key,required this.index,required this.actionIndex,});

  @override
  State<OrderStatusActions> createState() => _OrderStatusActionsState();
}

class _OrderStatusActionsState extends State<OrderStatusActions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
            (index) {
          return Container(
            height: 8,
            width: 8,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:  widget.actionIndex > widget.index ? Colors.green : Colors.red,
            ),
          );
        },
      ),
    );
  }
}
