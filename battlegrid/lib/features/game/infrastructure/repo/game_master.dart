import 'package:battlegrid/features/game/domain/entities/game_piece.dart';
import 'package:battlegrid/features/game/domain/entities/location.dart';

import 'package:collection/collection.dart';

import '../../domain/enums/piece_color.dart';
import '../model/bishop.dart';
import '../model/king.dart';
import '../model/knight.dart';
import '../model/pawn.dart';
import '../model/queen.dart';
import '../model/rook.dart';

class GameMaster {
  late final List<GamePiece> _allBlackPieces;
  late final List<GamePiece> _allWhitePieces;
  List<GamePiece> get allGamePiece => [..._allBlackPieces, ..._allWhitePieces];

  GameMaster({
    required List<GamePiece> blacks,
    required List<GamePiece> whites,
  }) {
    _allBlackPieces = blacks;
    _allWhitePieces = whites;
  }

  GameMaster.newGame()
      : this(
          blacks: [
            King(Location(5, 0), PieceColor.black),
            Rook(Location(0, 0), PieceColor.black),
            Rook(Location(10, 0), PieceColor.black),
            Knight(Location(1, 0), PieceColor.black),
            Knight(Location(9, 0), PieceColor.black),
            Bishop(Location(3, 0), PieceColor.black),
            Bishop(Location(7, 0), PieceColor.black),
            Queen(Location(4, 0), PieceColor.black),
            Queen(Location(6, 0), PieceColor.black),
            ...List.generate(
              11,
              (index) => Pawn(Location(index, 1), PieceColor.black),
            ),
          ],
          whites: [
            King(Location(5, 10), PieceColor.white),
            Rook(Location(0, 10), PieceColor.white),
            Rook(Location(10, 10), PieceColor.white),
            Knight(Location(1, 10), PieceColor.white),
            Knight(Location(9, 10), PieceColor.white),
            Bishop(Location(3, 10), PieceColor.white),
            Bishop(Location(7, 10), PieceColor.white),
            Queen(Location(4, 10), PieceColor.white),
            Queen(Location(6, 10), PieceColor.white),
            ...List.generate(
              11,
              (index) => Pawn(Location(index, 9), PieceColor.white),
            ),
          ],
        );

  GamePiece? getGamePieceByCoordinate(
    int xCord,
    int yCord,
  ) {
    final location = Location(xCord, yCord);
    return allGamePiece.firstWhereOrNull((piece) => location == piece.location);
  }

  bool canPieceMoveToThisLocation(
    GamePiece piece,
    int xCord,
    int yCord,
  ) {
    final pieceMoves = piece.getPieceMoves(allGamePiece, xCord, yCord);
    const deepEquality = DeepCollectionEquality.unordered();

    if (deepEquality.equals(
      pieceMoves.legalMoves,
      pieceMoves.possibleMoves,
    )) {
      return pieceMoves.possibleMoves
          .any((location) => location == Location(xCord, yCord));
    } else {
      pieceMoves.legalMoves.removeWhere(
          (location) => pieceMoves.possibleMoves.contains(location));
      final remainingLocation = pieceMoves.legalMoves;

      final isPieceInLocation =
          remainingLocation.contains(Location(xCord, yCord));
      if (isPieceInLocation) {
        return canPieceMoveToThisLocation(piece, xCord, yCord);
      } else {
        return true;
      }
    }
    // will test tomorrow TODO
  }

  bool isPieceOnLocation(
    int xCord,
    int yCord,
  ) {
    return getGamePieceByCoordinate(xCord, yCord) == null ? false : true;
  }

  bool canThisPieceKillPieceOnLocation(
    GamePiece piece,
    int xCord,
    int yCord,
  ) {
    final gamePiece = getGamePieceByCoordinate(xCord, yCord);
    return piece.canKillPieceOnLocation(gamePiece!);
  }

// hacky for now,
//need to make all fields final
  void updateLocation(
    GamePiece piece,
    int newXCord,
    int newYCord,
  ) {
    piece.location.xCord = newXCord;
    piece.location.yCord = newYCord;
  }
}
