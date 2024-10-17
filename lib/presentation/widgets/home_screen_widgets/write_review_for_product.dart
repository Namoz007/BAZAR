import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/details/app_details.dart';
import '../../../data/models/review_model.dart';
import '../../screens/home_screen/products_bloc/products_bloc.dart';
import '../../screens/home_screen/products_bloc/products_bloc_evetn.dart';

class WriteReviewForProduct extends StatefulWidget {
  String productId;
  productCategoryTypes type;
  WriteReviewForProduct({
    super.key,
    required this.productId,
    required this.type,
  });

  @override
  State<WriteReviewForProduct> createState() => _WriteReviewForProductState();
}

class _WriteReviewForProductState extends State<WriteReviewForProduct> {
  double score = 0;
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int index = 0; index < 5; index++)
                InkWell(
                  onTap: () {
                    setState(() {
                      score = index + 1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      score >= index + 1 ? Icons.star : Icons.star_border,
                      color: score >= index + 1 ? Colors.yellow : Colors.blue,
                      size: 40,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _textController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: "Comment",
              prefixIcon: const Icon(Icons.comment),
              suffixIcon: InkWell(
                onTap: () {
                  context.read<ProductsBloc>().add(
                        WriteReviewForProductsBlocEvent(
                          review: ReviewModel(
                            id: '',
                            userId: AppDetails.model!.id,
                            score: score,
                            message: _textController.text,
                            userName: AppDetails.model!.fullName,
                            productId: widget.productId,
                          ),
                          type: widget.type,
                        ),
                      );
                },
                child: const Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
