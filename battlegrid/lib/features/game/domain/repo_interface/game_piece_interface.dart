import 'package:battlegrid/features/game/domain/entities/game_piece.dart';
import 'package:battlegrid/features/game/domain/entities/location.dart';


abstract interface class GamePieceInterface {
  List<Location?> thisPieceLegalMoves(
    List<GamePiece> otherGamePieces, {
    bool checkObstruction = false,
  });

  List<Location?> thisPiecePossibleMoves(
    List<GamePiece> otherGamePieces, {
    bool checkObstruction = true,
  });

  bool canKillPieceOnLocation(GamePiece gamePiece);
}
