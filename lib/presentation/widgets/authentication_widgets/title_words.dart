import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TitleWords extends StatefulWidget {
  String firstWord;
  String secondWord;
  TitleWords({super.key,required this.firstWord,required this.secondWord,});

  @override
  State<TitleWords> createState() => _TitleWordsState();
}

class _TitleWordsState extends State<TitleWords> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/svgs/icons/logo.svg"),
        const SizedBox(height: 16,),
        Text(widget.firstWord,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
        const SizedBox(height: 8,),
        Text(widget.secondWord,style: const TextStyle(fontSize: 12,color: Color(0xFF9098B1)),)
      ],
    );
  }
}
