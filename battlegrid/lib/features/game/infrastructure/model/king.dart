import 'package:battlegrid/features/game/domain/entities/game_piece.dart';
import 'package:battlegrid/features/game/domain/enums/piece_type.dart';
import 'package:battlegrid/features/game/domain/repo_interface/game_piece_interface.dart';

class King extends GamePiece implements GamePieceInterface {
  King(
    super.location,
    super._color,
  ) {
    super.pieceType = PieceType.king;
  }

  @override
  List thisPieceLegalMoves() {
    throw UnimplementedError();
  }
}
