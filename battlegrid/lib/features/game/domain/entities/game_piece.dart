import 'package:battlegrid/features/game/domain/entities/location.dart';
import 'package:battlegrid/features/game/domain/enums/piece_type.dart';

import '../../../../core/constants/game_setting_constants.dart';
import '../enums/diagonal_moves.dart';
import '../enums/piece_color.dart';

abstract class GamePiece {
  final Location location;
  late final PieceType pieceType;
  final PieceColor _color;

  GamePiece(
    this.location,
    this._color,
  );

  String get name => pieceType.name;
  String get imageSourcePath =>
      "assets/icons/pieces/${_color.name}/${_color.name}_${pieceType.name}.svg";

  List<Location> get allPossibleMoves => List.generate(
        numberOfTileSlotOnEachAxis,
        (yIndex) => List.generate(
          numberOfTileSlotOnEachAxis,
          (xIndex) => Location(xIndex, yIndex),
        ),
      ).expand((element) => element).toList();

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

// 
}
