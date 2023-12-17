import 'package:battlegrid/features/game/domain/entities/game_piece.dart';
import 'package:battlegrid/features/game/domain/repo_interface/game_piece_interface.dart';

import '../../domain/enums/piece_type.dart';

class Rook extends GamePiece implements GamePieceInterface {
  Rook(super.location, super.color) {
    super.pieceType = PieceType.rook;
  }

  @override
  List thisPieceLegalMoves() {
    // TODO: implement thisPieceLegalMoves
    throw UnimplementedError();
  }
}
