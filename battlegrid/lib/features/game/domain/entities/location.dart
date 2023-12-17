import 'package:battlegrid/core/constants/game_setting_constants.dart';

class Location {
  final int xCord;
  final int yCord;

  Location(this.xCord, this.yCord);

  bool get isLocationValid =>
      (xCord < numberOfTileSlotOnEachAxis && xCord >= 0) &&
      (yCord < numberOfTileSlotOnEachAxis && yCord >= 0);
}
