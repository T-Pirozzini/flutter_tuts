import 'package:flame/game.dart';
import 'actors/ember.dart';
import 'actors/water_enemy.dart';
import 'managers/segment_manager.dart';
import 'objects/ground_block.dart';
import 'objects/platform_block.dart';
import 'objects/star.dart';
import 'package:flutter/material.dart';

class EmberQuestGame extends FlameGame {
  EmberQuestGame();

  late EmberPlayer _ember;
  double objectSpeed = 0.0;
  final Vector2 velocity = Vector2.zero();
  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'block.png',
      'ember.png',
      'ground.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
    ]);
    initializeGame();
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      switch (block.blockType) {
        case GroundBlock:
          add(GroundBlock(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));
          break;
        case PlatformBlock:
          add(PlatformBlock(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));
          break;
        case Star:
          add(Star(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));
          break;
        case WaterEnemy:
          add(WaterEnemy(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));
          break;
      }
    }
  }

  void initializeGame() {
    // Assume that size.x < 3200
    final segmentsToLoad = (size.x / 640).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (640 * i).toDouble());
    }

    _ember = EmberPlayer(
      position: Vector2(128, canvasSize.y - 70),
    );
    add(_ember);
  }
}
