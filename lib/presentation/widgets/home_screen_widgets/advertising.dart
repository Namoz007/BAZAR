import 'package:flutter/material.dart';

class Advertising extends StatefulWidget {
  const Advertising({super.key});

  @override
  State<Advertising> createState() => _AdvertisingState();
}

class _AdvertisingState extends State<Advertising> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 140,
          margin: const EdgeInsets.only(left: 20,top: 20,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.blue,),
          ),
          alignment: Alignment.center,
          child: Text("BAZAR Advertising",style: TextStyle(fontSize: 35),),
        );
      },
    );
  }
}
