import 'package:flutter/material.dart';

import '../../../domain/entities/product.dart';

class ShowProductForMenu extends StatefulWidget {
  Product product;
  ShowProductForMenu({super.key,required this.product,});

  @override
  State<ShowProductForMenu> createState() => _ShowProductForMenuState();
}

class _ShowProductForMenuState extends State<ShowProductForMenu> {
  double score = 0;

  @override
  void initState() {
    super.initState();
    for(int i = 0;i < widget.product.reviews.length;i++) {
      score += widget.product.reviews[i].score;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                image: DecorationImage(
                  image: NetworkImage(widget.product.imageUrl[0]),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.circular(20)
            ),
          ),

          Text(widget.product.name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12,),overflow: TextOverflow.ellipsis,),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for(int i = 0;i < 5;i++)
                Icon(score > i ? Icons.star: Icons.star_border,color: score > i ? const Color(0xFFFFC833) : const Color(0xFFEBF0FF),),
            ],
          ),

          Text("\$${widget.product.price}",style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Color(0xFF40BFFF),),)

        ],
      ),
    );
  }
}
