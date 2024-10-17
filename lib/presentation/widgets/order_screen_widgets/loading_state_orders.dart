import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class LoadingStateOrders extends StatefulWidget {
  const LoadingStateOrders({super.key});

  @override
  State<LoadingStateOrders> createState() => _LoadingStateOrdersState();
}

class _LoadingStateOrdersState extends State<LoadingStateOrders> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: Container(
        width: double.infinity,
        height: 250,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
