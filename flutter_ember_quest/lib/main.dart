import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'ember_quest.dart';

void main() {
  runApp(
    const GameWidget<EmberQuestGame>.controlled(
      gameFactory: EmberQuestGame.new,
    ),
  );
}
