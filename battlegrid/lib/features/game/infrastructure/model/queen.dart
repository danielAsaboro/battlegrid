import 'package:battlegrid/features/game/domain/entities/game_piece.dart';
import 'package:battlegrid/features/game/domain/repo_interface/game_piece_interface.dart';

import '../../domain/enums/piece_type.dart';

class Queen extends GamePiece implements GamePieceInterface {
  Queen(super.location, super.color) {
    super.pieceType = PieceType.queen;
  }

  @override
  List thisPieceLegalMoves() {
    // TODO: implement thisPieceLegalMoves
    throw UnimplementedError();
  }
}
