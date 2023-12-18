import 'package:battlegrid/core/constants/game_setting_constants.dart';

class Location {
  int xCord;
  int yCord;

  Location(this.xCord, this.yCord);

  bool get isLocationValid =>
      (xCord < numberOfTileSlotOnEachAxis && xCord >= 0) &&
      (yCord < numberOfTileSlotOnEachAxis && yCord >= 0);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Location && other.xCord == xCord && other.yCord == yCord;
  }

  @override
  int get hashCode => xCord.hashCode ^ yCord.hashCode;

}
