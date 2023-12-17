import 'package:battlegrid/features/game/domain/entities/location.dart';

import '../../../../core/constants/game_setting_constants.dart';
import '../enums/piece_color.dart';

abstract class GamePiece {
  final Location location;
  final String _name;
  final PieceColor _color;

  GamePiece(this.location, this._name, this._color);

  String get name => _name;
  String get imageUrl =>
      "assets/images/pieces/${_color.name}/${_color.name}_$_name.png";

  List<Location> get allPossibleMoves => List.generate(
        numberOfTileSlotOnEachAxis,
        (yIndex) => List.generate(
          numberOfTileSlotOnEachAxis,
          (xIndex) => Location(xIndex, yIndex),
        ),
      ).expand((element) => element).toList();

  List allLegalMoves();

  List<Location> _generateMovesOnDiagonal(
    GamePiece piece,
    DiagonalMove diagonalMove,
  ) {
    switch (diagonalMove) {
      case DiagonalMove.topRight:
        return List.generate(
          numberOfTileSlotOnEachAxis,
          (index) => Location(
              piece.location.xCord + index, piece.location.yCord - index),
        );
      case DiagonalMove.topLeft:
        return List.generate(
          numberOfTileSlotOnEachAxis,
          (index) => Location(
              piece.location.xCord - index, piece.location.yCord - index),
        );
      case DiagonalMove.bottomLeft:
        return List.generate(
          numberOfTileSlotOnEachAxis,
          (index) => Location(
              piece.location.xCord - index, piece.location.yCord + index),
        );
      case DiagonalMove.bottomRight:
        return List.generate(
          numberOfTileSlotOnEachAxis,
          (index) => Location(
              piece.location.xCord + index, piece.location.yCord + index),
        );
      default:
        throw ArgumentError('Unexpected value: $diagonalMove. Playing?!!');
    }
  }
}

enum DiagonalMove { topRight, bottomRight, bottomLeft, topLeft }
