import 'package:battlegrid/features/game/domain/entities/location.dart';
import 'package:battlegrid/features/game/domain/enums/straight_moves.dart';
import 'package:battlegrid/features/game/domain/repo_interface/game_piece_interface.dart';

import '../../domain/entities/game_piece.dart';
import '../../domain/enums/piece_type.dart';

class Pawn extends GamePiece implements GamePieceInterface {
  final List<PieceType> killAbleGamePiece = [
    PieceType.bishop,
    PieceType.knight,
    PieceType.pawn
  ];

  Pawn(super.location, super.color) {
    super.pieceType = PieceType.pawn;
  }

  @override
  bool canPieceMoveHere(
    List<GamePiece> otherGamePieces,
    int xCord,
    int yCord,
  ) {
    final pieceLegalMoves = thisPieceLegalMoves(otherGamePieces);
    final piecePossibleMoves = thisPiecePossibleMoves(otherGamePieces);

    if (pieceLegalMoves != piecePossibleMoves) {
      //
    }

    return false;
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
        2,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
      ...generateValidStraightMoves(
        StraightMove.right,
        2,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
      ...generateValidStraightMoves(
        StraightMove.bottom,
        2,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
      ...generateValidStraightMoves(
        StraightMove.left,
        2,
        otherGamePieces,
        checkObstruction: checkObstruction,
      ),
    ];
  }

  @override
  bool canKillPieceOnLocation(GamePiece gamePiece) {
    return killAbleGamePiece.contains(gamePiece.pieceType);
  }

  @override
  List<Location?> thisPiecePossibleMoves(
    List<GamePiece> otherGamePieces, {
    bool checkObstruction = true,
  }) {
    return thisPieceLegalMoves(otherGamePieces, checkObstruction: true);
  }
}
