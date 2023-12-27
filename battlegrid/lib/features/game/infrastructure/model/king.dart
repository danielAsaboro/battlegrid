import 'package:battlegrid/features/game/domain/entities/game_piece.dart';
import 'package:battlegrid/features/game/domain/enums/diagonal_moves.dart';
import 'package:battlegrid/features/game/domain/enums/piece_type.dart';
import 'package:battlegrid/features/game/domain/enums/straight_moves.dart';
import 'package:battlegrid/features/game/domain/repo_interface/game_piece_interface.dart';

import '../../domain/entities/location.dart';

class King extends GamePiece implements GamePieceInterface {
  static const List<PieceType> capturableGamePieces = [
    // PieceType.bishop,
    // PieceType.knight,
    // PieceType.pawn
  ];

  King(
    super.location,
    super._color,
  ) {
    super.pieceType = PieceType.king;
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
        1,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
      ...generateValidDiagonalMoves(
        DiagonalMove.bottomRight,
        1,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
      ...generateValidDiagonalMoves(
        DiagonalMove.bottomLeft,
        1,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
      ...generateValidDiagonalMoves(
        DiagonalMove.topLeft,
        1,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
      ...generateValidStraightMoves(
        StraightMove.up,
        1,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
      ...generateValidStraightMoves(
        StraightMove.right,
        1,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
      ...generateValidStraightMoves(
        StraightMove.bottom,
        1,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
      ...generateValidStraightMoves(
        StraightMove.left,
        1,
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
    return King(Location(newXCord, newYCord), color);
  }
}
