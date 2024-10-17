import 'package:flutter/material.dart';

class ImgsScrolWidgets extends StatefulWidget {
  int length;
  PageController controller;
  ImgsScrolWidgets({super.key,required this.length,required this.controller,});

  @override
  State<ImgsScrolWidgets> createState() => _ImgsScrolWidgetsState();
}

class _ImgsScrolWidgetsState extends State<ImgsScrolWidgets> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.length,
            (index) {
          return InkWell(
            onTap: () {
              widget.controller.animateToPage(
                index,
                duration: const Duration(microseconds: 400),
                curve: Curves.linear,
              );
            },
            child: Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.controller.initialPage == index
                    ? Colors.green
                    : Colors.blue,
              ),
            ),
          );
        },
      ),
    );
  }
}
