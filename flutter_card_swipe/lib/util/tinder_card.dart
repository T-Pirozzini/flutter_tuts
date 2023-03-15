import 'package:flutter/material.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

// ignore: must_be_immutable
class TinderCard extends StatelessWidget {
  final SwipeableCardSectionController _cardController =
      SwipeableCardSectionController();

  TinderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SwipeableCardsSection(
      cardController: _cardController,
      context: context,
      items: [
        Container(
          color: Colors.amber,
        ),
        Container(
          color: Colors.deepOrange,
        ),
        Container(
          color: Colors.deepPurple,
        ),
      ],      
    );
  }
}
