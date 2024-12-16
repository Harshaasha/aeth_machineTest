import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dummtProduct.dart';


class Secondscreeneg extends StatefulWidget {
  const Secondscreeneg({super.key});

  @override
  State<Secondscreeneg> createState() => _SecondscreenegState();
}

class _SecondscreenegState extends State<Secondscreeneg> {
  @override
  Widget build(BuildContext context) {
    final id=ModalRoute.of(context)?.settings.arguments;
    final data=dammyproduct.firstWhere((product)=>product["id"]==id);
    return Scaffold (
      body: Container(
        child: Column(
          children: [
            Text("${data["name"]}"),
            Image(image: AssetImage("${data["image"]}")),
            Text("${data["rate"]}"),
            Text("${data["description"]}"),
          ],


        ),
      ),

    );
  }
}
