import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.deepOrange,
        color: Colors.deepOrange.shade100,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {          
        },
        items: const [
          Icon(Icons.home),
          Icon(Icons.favorite),
          Icon(Icons.settings),
        ],
      ),
    );
  }
}
