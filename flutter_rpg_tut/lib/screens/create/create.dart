import 'package:flutter/material.dart';
import 'package:flutter_rpg_tut/models/character.dart';
import 'package:flutter_rpg_tut/models/vocation.dart';
import 'package:flutter_rpg_tut/screens/create/vocation_card.dart';
import 'package:flutter_rpg_tut/shared/styled_button.dart';
import 'package:flutter_rpg_tut/shared/styled_text.dart';
import 'package:flutter_rpg_tut/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
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
      return;
    }
    if (_sloganController.text.trim().isEmpty) {
      // show error dialog
      return;
    }
    characters.add(Character(
      name: _nameController.text.trim(),
      slogan: _sloganController.text.trim(),
      vocation: selectedVocation,
      id: uuid.v4(),
    ));
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

            // good lukc message
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