import 'package:flutter/material.dart';

class ProductImgs extends StatefulWidget {
  List<String> imgs;
  PageController controller;
  ProductImgs({super.key,required this.imgs,required this.controller,});

  @override
  State<ProductImgs> createState() => _ProductImgsState();
}

class _ProductImgsState extends State<ProductImgs> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.controller,
      itemCount: widget.imgs.length,
      itemBuilder: (context, i) {
        return Container(
          width: double.infinity,
          height: 238,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.imgs[i]),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
