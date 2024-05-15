import 'package:flutter/material.dart';
import 'package:flutter_rpg_tut/models/character.dart';
import 'package:flutter_rpg_tut/models/vocation.dart';
import 'package:flutter_rpg_tut/screens/create/vocation_card.dart';
import 'package:flutter_rpg_tut/screens/home/home.dart';
import 'package:flutter_rpg_tut/services/character_store.dart';
import 'package:flutter_rpg_tut/shared/styled_button.dart';
import 'package:flutter_rpg_tut/shared/styled_text.dart';
import 'package:flutter_rpg_tut/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  // handling vocation selection
  Vocation selectedVocation = Vocation.junkie;

  void updateVocation(Vocation vocation) {
    setState(() {
      selectedVocation = vocation;
    });
  }

  // submit handler
  void handleSubmit() {
    if (_nameController.text.trim().isEmpty) {
      // show error dialog
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title:
                  const Center(child: StyledHeading('Missing Character Name')),
              content: const StyledText(
                  'Every good RPG character needs a great name...'),
              actions: [
                StyledButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const StyledHeading('close'),
                )
              ],
              actionsAlignment: MainAxisAlignment.center,
            );
          });
      return;
    }
    if (_sloganController.text.trim().isEmpty) {
      // show error dialog
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Center(child: StyledHeading('Missing Slogan')),
              content: const StyledText('Remember to add a catchy slogan...'),
              actions: [
                StyledButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const StyledHeading('close'),
                )
              ],
              actionsAlignment: MainAxisAlignment.center,
            );
          });
      return;
    }

    Provider.of<CharacterStore>(context, listen: false).addCharacter(
      Character(
        name: _nameController.text.trim(),
        slogan: _sloganController.text.trim(),
        vocation: selectedVocation,
        id: uuid.v4(),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => const Home(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Character Creation'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(children: [
            // welcome message
            Center(
              child: Icon(Icons.code, color: AppColors.primaryColor),
            ),
            const Center(
              child: StyledHeading('Welcome, new player.'),
            ),
            const Center(
              child: StyledText('Create a name & slogan for your character.'),
            ),
            const SizedBox(height: 30),

            // input for name & slogan
            TextField(
              controller: _nameController,
              style: GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.bodyMedium),
              cursorColor: AppColors.textColor,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_2),
                label: StyledText('Character name'),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _sloganController,
              style: GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.bodyMedium),
              cursorColor: AppColors.textColor,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.chat),
                label: StyledText('Character slogan'),
              ),
            ),
            const SizedBox(height: 30),

            // select vocation title
            Center(
              child: Icon(Icons.code, color: AppColors.primaryColor),
            ),
            const Center(
              child: StyledHeading('Choose a vocation.'),
            ),
            const Center(
              child: StyledText('This determines your available skills.'),
            ),

            // vocation cards
            VocationCard(
              vocation: Vocation.junkie,
              onTap: updateVocation,
              selected: selectedVocation == Vocation.junkie,
            ),
            VocationCard(
              vocation: Vocation.ninja,
              onTap: updateVocation,
              selected: selectedVocation == Vocation.ninja,
            ),
            VocationCard(
              vocation: Vocation.raider,
              onTap: updateVocation,
              selected: selectedVocation == Vocation.raider,
            ),
            VocationCard(
              vocation: Vocation.wizard,
              onTap: updateVocation,
              selected: selectedVocation == Vocation.wizard,
            ),

            // good luck message
            Center(
              child: Icon(Icons.code, color: AppColors.primaryColor),
            ),
            const Center(
              child: StyledHeading('Good Luck.'),
            ),
            const Center(
              child: StyledText('And enjoy the journey...'),
            ),

            Center(
              child: StyledButton(
                onPressed: handleSubmit,
                child: const StyledHeading('Create Character'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
