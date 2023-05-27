import "package:flutter/material.dart";

class DonutTile extends StatelessWidget {
  final String donutFlavor;
  final String donutPrice;
  final donutColor;
  final String imageName;

  const DonutTile(
      {super.key,
      required this.donutFlavor,
      required this.donutPrice,
      required this.donutColor,
      required this.imageName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: donutColor[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // price
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: donutColor[100],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Text('\$$donutPrice'),
                ),
              ],
            ),

            // donut picture
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Image.asset(imageName),
            ),

            // donut flavour
            Text(
              donutFlavor,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              "Donut Shop",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),

            const SizedBox(height: 4),

            // love icon + add button
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.favorite, color: Colors.pink[400]),
                    Icon(Icons.add, color: Colors.grey[800]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
