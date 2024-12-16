import 'package:aeth_analytica/Products/screen2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'dummtProduct.dart';
void main(){
  runApp(MaterialApp(home: Firstscreeneg(),
    debugShowCheckedModeBanner: false,
    routes: {
      "Secondscreeneg":(context)=>Secondscreeneg(),
    },
  ));
}
class Firstscreeneg extends StatefulWidget {
  const Firstscreeneg({super.key});

  @override
  State<Firstscreeneg> createState() => _FirstscreenegState();
}

class _FirstscreenegState extends State<Firstscreeneg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
          title: const Text('Products'),
          actions: [
      IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {

      },
    ),
   ],
    ),
      body: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
          children: dammyproduct.map((product)=>GestureDetector(
            child: Column(
              children: [
                Text(product["name"]),
                Image(image: AssetImage(product["image"], )),
              ],
            ),
            onTap: ()=>getproduct(context,product["id"]),
          )).toList()
      ),
    );
  }

  void  getproduct(BuildContext context, product) {
    Navigator.pushNamed(context, "Secondscreeneg",arguments: product);
  }
}
