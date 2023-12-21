import 'package:battlegrid/features/game/domain/entities/location.dart';
import 'package:battlegrid/features/game/domain/enums/piece_type.dart';
import 'package:battlegrid/features/game/domain/enums/straight_moves.dart';

import '../../../../core/constants/game_setting_constants.dart';
import '../enums/diagonal_moves.dart';
import '../enums/knight_l_moves.dart';
import '../enums/piece_color.dart';

import 'package:collection/collection.dart';

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

  List<Location> get allPossibleBoardMoves => List.generate(
        numberOfTileSlotOnEachAxis,
        (yIndex) => List.generate(
          numberOfTileSlotOnEachAxis,
          (xIndex) => Location(xIndex, yIndex),
        ),
      ).expand((element) => element).toList();

  List<Location?> _generateDiagonalMoves(
    DiagonalMove diagonalMove,
    int numberOfStepsToMove,
    List<GamePiece> allGamePiece, {
    bool checkObstruction = false,
  }) {
    if (checkObstruction) {
      bool isPieceObstructed = false;
      return List.generate(numberOfStepsToMove, (index) {
        late final Location locationInCheck;
        switch (diagonalMove) {
          case DiagonalMove.topRight:
            locationInCheck = Location(
              location.xCord + index,
              location.yCord - index,
            );
            break;
          case DiagonalMove.bottomRight:
            locationInCheck = Location(
              location.xCord + index,
              location.yCord + index,
            );
            break;
          case DiagonalMove.bottomLeft:
            locationInCheck = Location(
              location.xCord - index,
              location.yCord + index,
            );
            break;
          case DiagonalMove.topLeft:
            locationInCheck = Location(
              location.xCord - index,
              location.yCord - index,
            );
            break;
        }

        final isTherePieceOnLocation = allGamePiece
            .any((eachGamePiece) => eachGamePiece.location == locationInCheck);

        if (isTherePieceOnLocation) {
          isPieceObstructed = true;
        }
        return isPieceObstructed ? null : locationInCheck;
      });
    } else {
      return List.generate(numberOfStepsToMove, (index) {
        late final Location locationInCheck;
        switch (diagonalMove) {
          case DiagonalMove.topRight:
            locationInCheck = Location(
              location.xCord + index,
              location.yCord - index,
            );
            break;
          case DiagonalMove.bottomRight:
            locationInCheck = Location(
              location.xCord + index,
              location.yCord + index,
            );
            break;
          case DiagonalMove.bottomLeft:
            locationInCheck = Location(
              location.xCord - index,
              location.yCord + index,
            );
            break;
          case DiagonalMove.topLeft:
            locationInCheck = Location(
              location.xCord - index,
              location.yCord - index,
            );
            break;
        }

        return locationInCheck;
      });
    }
  }

  List<Location?> _generateStraightMoves(
    StraightMove straightMove,
    int numberOfStepsToMove,
    List<GamePiece> allGamePiece, {
    bool checkObstruction = false,
  }) {
    if (checkObstruction) {
      bool isPieceObstructed = false;
      return List.generate(numberOfStepsToMove, (index) {
        late final Location locationInCheck;
        switch (straightMove) {
          case StraightMove.up:
            locationInCheck = Location(location.xCord, location.yCord - index);
            break;
          case StraightMove.right:
            locationInCheck = Location(location.xCord + index, location.yCord);
            break;
          case StraightMove.bottom:
            locationInCheck = Location(location.xCord, location.yCord + index);
            break;
          case StraightMove.left:
            locationInCheck = Location(location.xCord - index, location.yCord);
            break;
        }
        final isTherePieceOnLocation = allGamePiece
            .any((eachGamePiece) => eachGamePiece.location == locationInCheck);

        if (isTherePieceOnLocation) {
          isPieceObstructed = true;
        }
        return isPieceObstructed ? null : locationInCheck;
      });
    } else {
      return List.generate(numberOfStepsToMove, (index) {
        late final Location locationInCheck;
        switch (straightMove) {
          case StraightMove.up:
            locationInCheck = Location(location.xCord, location.yCord - index);
            break;
          case StraightMove.right:
            locationInCheck = Location(location.xCord + index, location.yCord);
            break;
          case StraightMove.bottom:
            locationInCheck = Location(location.xCord, location.yCord + index);
            break;
          case StraightMove.left:
            locationInCheck = Location(location.xCord - index, location.yCord);
            break;
        }
        return locationInCheck;
      });
    }
  }

  List<Location> generateValidDiagonalMoves(
    DiagonalMove diagonalMove,
    int numberOfStepsToMove,
    List<GamePiece> allGamePiece, {
    bool checkObstruction = false,
  }) {
    return _generateDiagonalMoves(
      diagonalMove,
      numberOfStepsToMove,
      allGamePiece,
      checkObstruction: checkObstruction,
    )
        .whereType<Location>()
        .where((element) => element.isLocationValid)
        .toList();
  }

  List<Location> generateValidStraightMoves(
    StraightMove straightMove,
    int numberOfStepsToMove,
    List<GamePiece> allGamePiece, {
    bool checkObstruction = false,
  }) {
    return _generateStraightMoves(
      straightMove,
      numberOfStepsToMove,
      allGamePiece,
      checkObstruction: checkObstruction,
    )
        .whereType<Location>()
        .where((element) => element.isLocationValid)
        .toList();
  }

  ({
    List<Location?> legalMoves,
    List<Location?> possibleMoves,
  }) getPieceMoves(
    List<GamePiece> otherGamePieces,
    int xCord,
    int yCord,
  );

  bool canKillPieceOnLocation(GamePiece gamePiece);
//

  List<Location?> _generateTheLMoves(
    KnightLMove knightLMove,
    int numberOfStepsToMove,
    List<GamePiece> allGamePiece, {
    bool checkObstruction = false,
  }) {
    if (checkObstruction) {
      bool isPieceObstructed = false;
      return List.generate(numberOfStepsToMove, (index) {
        late final Location locationInCheck;
        switch (knightLMove) {
          case KnightLMove.upRight:
            locationInCheck =
                Location(location.xCord + 1, (location.yCord - 2) - index);
            break;
          case KnightLMove.rightUp:
            locationInCheck =
                Location((location.xCord + 2) + index, location.yCord - 1);
            break;

          case KnightLMove.rightDown:
            locationInCheck =
                Location((location.xCord + 2) + index, location.yCord + 1);
            break;
          case KnightLMove.downRight:
            locationInCheck =
                Location(location.xCord + 1, (location.yCord + 2) - index);
            break;
          case KnightLMove.downLeft:
            locationInCheck =
                Location(location.xCord - 1, (location.yCord + 2) - index);
            break;
          case KnightLMove.leftDown:
            locationInCheck =
                Location((location.xCord - 2) + index, location.yCord - 1);
            break;
          case KnightLMove.leftUp:
            locationInCheck =
                Location((location.xCord - 2) + index, location.yCord + 1);
            break;
          case KnightLMove.upLeft:
            locationInCheck =
                Location(location.xCord - 1, (location.yCord - 2) - index);
            break;
        }
        final isTherePieceOnLocation = allGamePiece
            .any((eachGamePiece) => eachGamePiece.location == locationInCheck);

        if (isTherePieceOnLocation) {
          isPieceObstructed = true;
        }
        return isPieceObstructed ? null : locationInCheck;
      });
    } else {
      return List.generate(numberOfStepsToMove + 1, (index) {
        late final Location locationInCheck;
        switch (knightLMove) {
          case KnightLMove.upRight:
            locationInCheck =
                Location(location.xCord + 1, (location.yCord - 2) - index);
            break;
          case KnightLMove.rightUp:
            locationInCheck =
                Location((location.xCord + 2) + index, location.yCord - 1);
            break;
          case KnightLMove.rightDown:
            locationInCheck =
                Location((location.xCord + 2) + index, location.yCord + 1);
            break;
          case KnightLMove.downRight:
            locationInCheck =
                Location(location.xCord + 1, (location.yCord + 2) - index);
            break;
          case KnightLMove.downLeft:
            locationInCheck =
                Location(location.xCord - 1, (location.yCord + 2) - index);
            break;
          case KnightLMove.leftDown:
            locationInCheck =
                Location((location.xCord - 2) + index, location.yCord - 1);
            break;
          case KnightLMove.leftUp:
            locationInCheck =
                Location((location.xCord - 2) + index, location.yCord + 1);
            break;
          case KnightLMove.upLeft:
            locationInCheck =
                Location(location.xCord - 1, (location.yCord - 2) - index);
            break;
        }
        return locationInCheck;
      });
    }
  }

  List<Location> generateTheLMoves(
    KnightLMove knightLMove,
    int numberOfStepsToMove,
    List<GamePiece> allGamePiece, {
    bool checkObstruction = false,
  }) {
    return _generateTheLMoves(
      knightLMove,
      numberOfStepsToMove,
      allGamePiece,
      checkObstruction: checkObstruction,
    )
        .whereType<Location>()
        .where((element) => element.isLocationValid)
        .toList();
  }
}
