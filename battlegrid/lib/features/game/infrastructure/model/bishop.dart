import 'package:battlegrid/core/constants/game_setting_constants.dart';
import 'package:battlegrid/features/game/domain/entities/game_piece.dart';
import 'package:battlegrid/features/game/domain/repo_interface/game_piece_interface.dart';

import '../../domain/entities/location.dart';
import '../../domain/enums/diagonal_moves.dart';
import '../../domain/enums/piece_type.dart';

class Bishop extends GamePiece implements GamePieceInterface {
  static const List<PieceType> capturableGamePieces = [
    // PieceType.bishop,
    // PieceType.knight,
    // PieceType.pawn
  ];

  Bishop(super.location, super.color) {
    super.pieceType = PieceType.bishop;
  }

  @override
  ({List<Location?> legalMoves, List<Location?> possibleMoves}) getPieceMoves(
    List<GamePiece> otherGamePieces,
    int xCord,
    int yCord,
  ) {
    final pieceLegalMoves = thisPieceLegalMoves(otherGamePieces);
    final piecePossibleMoves = thisPiecePossibleMoves(otherGamePieces);

    return (
      legalMoves: pieceLegalMoves,
      possibleMoves: piecePossibleMoves,
    );
  }

  @override
  List<Location?> thisPieceLegalMoves(
    List<GamePiece> otherGamePieces, {
    bool checkObstruction = false,
  }) {
    return [
      ...generateValidDiagonalMoves(
        DiagonalMove.topRight,
        numberOfTileSlotOnEachAxis,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
      ...generateValidDiagonalMoves(
        DiagonalMove.bottomRight,
        numberOfTileSlotOnEachAxis,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
      ...generateValidDiagonalMoves(
        DiagonalMove.bottomLeft,
        numberOfTileSlotOnEachAxis,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
      ...generateValidDiagonalMoves(
        DiagonalMove.topLeft,
        numberOfTileSlotOnEachAxis,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
    ];
  }

  @override
  bool canKillPieceOnLocation(GamePiece gamePiece) {
    return capturableGamePieces.contains(gamePiece.pieceType);
  }

  @override
  List<Location?> thisPiecePossibleMoves(
    List<GamePiece> otherGamePieces, {
    bool checkObstruction = true,
  }) {
    return thisPieceLegalMoves(otherGamePieces, checkObstruction: true);
  }

  @override
  GamePiece updateLocation(int newXCord, int newYCord) {
    return Bishop(Location(newXCord, newYCord), color);
  }
}
