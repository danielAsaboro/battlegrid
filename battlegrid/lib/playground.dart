import 'package:battlegrid/core/constants/game_setting_constants.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

List allPossibleMoves() {
  // TODO
  return [];
}

main() {
  List allPossibleMoves() => List.generate(
          numberOfTileSlotOnEachAxis,
          (yIndex) => List.generate(
              numberOfTileSlotOnEachAxis, (xIndex) => [xIndex, yIndex]))
      .expand((element) => element)
      .toList();

  print(allPossibleMoves());
}
