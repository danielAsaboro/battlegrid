import 'package:battlegrid/features/game/domain/entities/game_piece.dart';
import 'package:battlegrid/features/game/domain/entities/location.dart';

import 'package:collection/collection.dart';

import '../../domain/enums/piece_color.dart';
import '../../domain/enums/turns.dart';
import '../model/bishop.dart';
import '../model/king.dart';
import '../model/knight.dart';
import '../model/pawn.dart';
import '../model/queen.dart';
import '../model/rook.dart';

class GameMaster {
  late final List<GamePiece> _allBlackPieces;
  late final List<GamePiece> _allWhitePieces;
  List<GamePiece> get allGamePiece => [..._allBlackPieces, ..._allWhitePieces];

  late final CurrentPlayer _currentPlayer;
  late final List<GamePiece>? _blackPieceOldPositions;
  late final List<GamePiece>? _whitePieceOldPositions;

  CurrentPlayer get getCurrentPlayer => _currentPlayer;
  List<GamePiece> get allBlackPieces => _allBlackPieces;
  List<GamePiece> get allWhitePieces => _allWhitePieces;

  List<GamePiece> get blackPieceOldPositions => _blackPieceOldPositions!;
  List<GamePiece> get whitePieceOldPositions => _whitePieceOldPositions!;

  GameMaster({
    required List<GamePiece> blacks,
    required List<GamePiece> whites,
    required CurrentPlayer currentPlayer,
    List<GamePiece>? oldBlacks,
    List<GamePiece>? oldWhites,
  }) {
    _allBlackPieces = blacks;
    _allWhitePieces = whites;
    _blackPieceOldPositions = oldBlacks;
    _whitePieceOldPositions = oldWhites;
    _currentPlayer = currentPlayer;
  }

  GameMaster.newGame()
      : this(
          blacks: [
            King(Location(5, 0), PieceColor.black),
            Rook(Location(0, 0), PieceColor.black),
            Rook(Location(10, 0), PieceColor.black),
            Knight(Location(1, 0), PieceColor.black),
            Knight(Location(9, 0), PieceColor.black),
            Bishop(Location(3, 0), PieceColor.black),
            Bishop(Location(7, 0), PieceColor.black),
            Queen(Location(4, 0), PieceColor.black),
            Queen(Location(6, 0), PieceColor.black),
            ...List.generate(
              11,
              (index) => Pawn(Location(index, 1), PieceColor.black),
            ),
          ],
          whites: [
            King(Location(5, 10), PieceColor.white),
            Rook(Location(0, 10), PieceColor.white),
            Rook(Location(10, 10), PieceColor.white),
            Knight(Location(1, 10), PieceColor.white),
            Knight(Location(9, 10), PieceColor.white),
            Bishop(Location(3, 10), PieceColor.white),
            Bishop(Location(7, 10), PieceColor.white),
            Queen(Location(4, 10), PieceColor.white),
            Queen(Location(6, 10), PieceColor.white),
            ...List.generate(
              11,
              (index) => Pawn(Location(index, 9), PieceColor.white),
            ),
          ],
          currentPlayer: CurrentPlayer.black,
        );

  GamePiece? getGamePieceByCoordinate(
    int xCord,
    int yCord,
  ) {
    final location = Location(xCord, yCord);
    return allGamePiece.firstWhereOrNull((piece) => location == piece.location);
  }

  bool canPieceMoveToThisLocation(
    GamePiece piece,
    int xCord,
    int yCord,
  ) {
    // return true;
    final pieceMoves = piece.getPieceMoves(allGamePiece, xCord, yCord);
    const deepEquality = DeepCollectionEquality.unordered();

    if (deepEquality.equals(
      pieceMoves.legalMoves,
      pieceMoves.possibleMoves,
    )) {
      return pieceMoves.possibleMoves
          .any((location) => location == Location(xCord, yCord));
    } else {
      final passingLegalMoves = [...pieceMoves.legalMoves];
      passingLegalMoves.removeWhere(
          (location) => pieceMoves.possibleMoves.contains(location));
      final remainingLocations = passingLegalMoves;
      print("remaining locations");
      print(remainingLocations);

      final isPieceInLocation =
          remainingLocations.contains(Location(xCord, yCord));
      if (isPieceInLocation) {
        print("yes");
        return canThisPieceKillPieceOnLocation(piece, xCord, yCord);
      }
      if (pieceMoves.legalMoves.contains(Location(xCord, yCord))) {
        return true;
      }
      return false;
      // return true; stop returning any how
    }
    // will test tomorrow TODO
  }

  bool isPieceOnLocation(
    int xCord,
    int yCord,
  ) {
    return getGamePieceByCoordinate(xCord, yCord) == null ? false : true;
  }

  bool canThisPieceKillPieceOnLocation(
    GamePiece piece,
    int xCord,
    int yCord,
  ) {
    final gamePiece = getGamePieceByCoordinate(xCord, yCord);
    final canKillPiece = piece.canKillPieceOnLocation(gamePiece!);
    if (canKillPiece) {
      // deleteThisPiece(xCord, yCord);
      //TODO score board go brh
      return true;
    }
    return false;
  }

  bool isTileDisabled(int xCord, int yCord) {
    {
      final gamePiece = getGamePieceByCoordinate(
        xCord,
        yCord,
      );
      print("current player: ${getCurrentPlayer.name}");
      if (gamePiece != null) {
        switch (getCurrentPlayer) {
          case CurrentPlayer.black:
            if (gamePiece.color == PieceColor.black) {
              return true;
            }
            break;
          case CurrentPlayer.white:
            if (gamePiece.color == PieceColor.white) {
              return true;
            }
            break;
          default:
            return false;
        }
      } else {
        return false;
      }
      return false;
    }
  }

  GameMaster copyWith({
    List<GamePiece>? blacks,
    List<GamePiece>? whites,
    List<GamePiece>? oldBlacks,
    List<GamePiece>? oldWhites,
    CurrentPlayer? passedCurrentPlayer,
  }) {
    return GameMaster(
      blacks: blacks ?? allBlackPieces,
      whites: whites ?? allWhitePieces,
      oldBlacks: oldBlacks ?? blackPieceOldPositions,
      oldWhites: oldWhites ?? whitePieceOldPositions,
      currentPlayer: passedCurrentPlayer ?? _currentPlayer,
    );
  }
}
