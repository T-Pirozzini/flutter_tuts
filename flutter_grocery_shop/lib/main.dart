import 'package:flutter/material.dart';
import 'package:flutter_grocery_shop/pages/intro_page.dart';
import 'package:provider/provider.dart';

import 'model/cart_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MaterialApp(
        title: 'Flutter Grocery Shop',
        home: IntroPage(),
      ),
    );
  }
}
