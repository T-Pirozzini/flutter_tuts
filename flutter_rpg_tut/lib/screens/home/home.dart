import 'package:flutter/material.dart';
import 'package:flutter_rpg_tut/models/character.dart';
import 'package:flutter_rpg_tut/screens/home/character_card.dart';
import 'package:flutter_rpg_tut/shared/styled_button.dart';
import 'package:flutter_rpg_tut/shared/styled_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Your Characters'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (_, index) {
                  return CharacterCard(characters[index]);
                },
                itemCount: characters.length,
              ),
            ),
            StyledButton(
              onPressed: () {},
              child: const StyledHeading('Create New'),
            )
          ],
        ),
      ),
    );
  }
}
