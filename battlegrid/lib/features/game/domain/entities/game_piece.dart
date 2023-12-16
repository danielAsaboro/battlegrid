import 'package:battlegrid/features/game/domain/entities/location.dart';

import '../enums/piece_color.dart';

abstract class GamePiece {
  final Location location;
  final String _name;
  final PieceColor _color;

  GamePiece(this.location, this._name, this._color);

  String get name => _name;
  String get imageUrl => "assets/images/${_color.name}/$_name.png";

  List allPossibleMoves() {
    // TODO
    return [];
  }

  List allLegalMoves();
}
