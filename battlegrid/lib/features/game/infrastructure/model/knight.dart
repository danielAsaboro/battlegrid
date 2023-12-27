import 'package:battlegrid/features/game/domain/entities/game_piece.dart';
import 'package:battlegrid/features/game/domain/entities/location.dart';
import 'package:battlegrid/features/game/domain/enums/knight_l_moves.dart';
import 'package:battlegrid/features/game/domain/repo_interface/game_piece_interface.dart';

import '../../domain/enums/piece_type.dart';
import '../../domain/enums/straight_moves.dart';

class Knight extends GamePiece implements GamePieceInterface {
  static const List<PieceType> capturableGamePieces = [
    // PieceType.bishop,
    // PieceType.knight,
    // PieceType.pawn
  ];

  Knight(super.location, super.color) {
    super.pieceType = PieceType.knight;
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
      ...generateValidStraightMoves(
        StraightMove.up,
        3,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
      ...generateValidStraightMoves(
        StraightMove.right,
        3,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
      ...generateValidStraightMoves(
        StraightMove.bottom,
        3,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
      ...generateValidStraightMoves(
        StraightMove.left,
        3,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
      ...generateTheLMoves(KnightLMove.upRight, 1, otherGamePieces),
      ...generateTheLMoves(KnightLMove.rightUp, 1, otherGamePieces),
      ...generateTheLMoves(KnightLMove.rightDown, 1, otherGamePieces),
      ...generateTheLMoves(KnightLMove.downRight, 1, otherGamePieces),
      ...generateTheLMoves(KnightLMove.downLeft, 1, otherGamePieces),
      ...generateTheLMoves(KnightLMove.leftDown, 1, otherGamePieces),
      ...generateTheLMoves(KnightLMove.leftUp, 1, otherGamePieces),
      ...generateTheLMoves(KnightLMove.upLeft, 1, otherGamePieces),
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
    return Knight(Location(newXCord, newYCord), color);
  }
}
