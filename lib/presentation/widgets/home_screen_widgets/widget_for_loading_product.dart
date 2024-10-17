import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WidgetForLoadingProduct extends StatefulWidget {
  const WidgetForLoadingProduct({super.key});

  @override
  State<WidgetForLoadingProduct> createState() => _WidgetForLoadingProductState();
}

class _WidgetForLoadingProductState extends State<WidgetForLoadingProduct> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade200,
      direction: ShimmerDirection.ttb,
      child: Container(
        width: 200,
        height: 200,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
