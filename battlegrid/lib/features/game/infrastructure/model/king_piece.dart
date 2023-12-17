import 'package:battlegrid/features/game/domain/entities/game_piece.dart';
import 'package:battlegrid/features/game/domain/entities/location.dart';
import 'package:battlegrid/features/game/domain/repo_interface/game_piece_interface.dart';

class KingGamePiece extends GamePiece implements GamePieceInterface {
  KingGamePiece(super.location, super._name, super._color);

  @override
  // TODO: implement imageUrl
  String get imageUrl => throw UnimplementedError();

  @override
  // TODO: implement location
  Location get location => throw UnimplementedError();

  @override
  // TODO: implement name
  String get name => throw UnimplementedError();

  @override
  List thisPieceLegalMoves() {
    // TODO: implement allLegalMoves
    throw UnimplementedError();
  }
}
