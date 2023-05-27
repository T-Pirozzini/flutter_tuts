import 'package:flutter/material.dart';

import '../util/donut_tile.dart';

class DonutTab extends StatelessWidget {
  // list of donuts
  List donutOnSale = [
    // [ donutFlavor, donutPrice, donutColor, imageName]
    ["Chocolate", "1.99", Colors.brown, "lib/images/chocolate.png"],
    ["Pistachio", "2.99", Colors.green, "lib/images/pistachio.png"],
    ["Strawberry", "3.99", Colors.pink, "lib/images/strawberry.png"],
    ["Cotton Candy", "4.99", Colors.blue, "lib/images/cotton_candy.png"],
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: donutOnSale.length,
      padding: const EdgeInsets.all(12.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.5),
      itemBuilder: (context, index) {
        return DonutTile(
          donutFlavor: donutOnSale[index][0],
          donutPrice: donutOnSale[index][1],
          donutColor: donutOnSale[index][2],
          imageName: donutOnSale[index][3],
        );
      },
    );
  }
}
