import 'package:battlegrid/features/game/domain/repo_interface/game_piece_interface.dart';

import '../../domain/entities/game_piece.dart';
import '../../domain/enums/piece_type.dart';

class Pawn extends GamePiece implements GamePieceInterface {
  Pawn(super.location, super.color) {
    super.pieceType = PieceType.pawn;
  }

  @override
  List thisPieceLegalMoves() {
    // TODO: implement thisPieceLegalMoves
    throw UnimplementedError();
  }
}
