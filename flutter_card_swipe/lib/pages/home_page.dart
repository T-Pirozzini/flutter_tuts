import 'package:flutter/material.dart';
import 'package:flutter_card_swipe/util/tinder_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TinderCard(),
      ),
    );
  }
}
