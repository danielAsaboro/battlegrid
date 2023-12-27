import 'package:battlegrid/features/game/domain/entities/location.dart';
import 'package:battlegrid/features/game/domain/enums/piece_color.dart';
import 'package:battlegrid/features/game/domain/enums/turns.dart';
import 'package:battlegrid/features/game/infrastructure/repo/game_master.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

import '../domain/entities/game_piece.dart';

class GameMasterNotifier extends Notifier<GameMaster> {
  @override
  build() {
    return GameMaster.newGame();
  }

  void undoMove() {
    final blackPiecesOldPosition = state.blackPieceOldPositions;
    final whitePiecesOldPosition = state.whitePieceOldPositions;

    state = state.copyWith(
      blacks: [...blackPiecesOldPosition],
      whites: [...whitePiecesOldPosition],
      passedCurrentPlayer: state.getCurrentPlayer == CurrentPlayer.black
          ? CurrentPlayer.white
          : CurrentPlayer.black,
    );
  }

  void changeCurrentPlayer() {
    print("changing current player");
    final currentPlayer = state.getCurrentPlayer;
    late final CurrentPlayer newCurrentPlayer;
    if (currentPlayer == CurrentPlayer.black) {
      newCurrentPlayer = CurrentPlayer.white;
    } else {
      newCurrentPlayer = CurrentPlayer.black;
    }

    state = GameMaster(
      blacks: [...state.allBlackPieces],
      whites: [...state.allWhitePieces],
      currentPlayer: newCurrentPlayer,
    );
  }

  void saveCurrentGameState() {
    print("saving game state");

    final blackPieces = state.allBlackPieces;
    final whitePieces = state.allWhitePieces;

    state = state.copyWith(
      blacks: [...blackPieces],
      whites: [...whitePieces],
      oldBlacks: [...blackPieces],
      oldWhites: [...whitePieces],
    );
  }

  void updateLocation(
    GamePiece piece,
    int newXCord,
    int newYCord,
  ) {
    print("updating location");
    saveCurrentGameState();
    final pieceColor = piece.color;
    final allBlackPieces = state.allBlackPieces;
    final allWhitePieces = state.allWhitePieces;

    int pieceIndex = -1; // Initialize with an invalid index

    switch (pieceColor) {
      case PieceColor.black:
        pieceIndex = state.allBlackPieces
            .indexWhere((gamePiece) => gamePiece.location == piece.location);
        break;
      case PieceColor.white:
        pieceIndex = state.allWhitePieces
            .indexWhere((gamePiece) => gamePiece.location == piece.location);
        break;
      default:
    }

    if (pieceIndex != -1) {
      switch (pieceColor) {
        case PieceColor.black:
          allBlackPieces[pieceIndex] = piece.updateLocation(newXCord, newYCord);
          break;
        case PieceColor.white:
          allWhitePieces[pieceIndex] = piece.updateLocation(newXCord, newYCord);
          break;
        default:
      }
    }

    state = state.copyWith(
      blacks: [...allBlackPieces],
      whites: [...allWhitePieces],
      passedCurrentPlayer: state.getCurrentPlayer == CurrentPlayer.black
          ? CurrentPlayer.white
          : CurrentPlayer.black,
    );
  }

  void deleteThisPiece(
    int xCord,
    int yCord,
  ) {
    print("deleting a piece");
    saveCurrentGameState();
    final gamePiece = state.getGamePieceByCoordinate(xCord, yCord);

    final allBlackPieces = state.allBlackPieces;
    final allWhitePieces = state.allWhitePieces;
    if (gamePiece != null) {
      if (gamePiece.color == PieceColor.black) {
        allBlackPieces.removeWhere(
          (gamePiece) => gamePiece.location == Location(xCord, yCord),
        );
      } else {
        allWhitePieces.removeWhere(
          (gamePiece) => gamePiece.location == Location(xCord, yCord),
        );
      }
    }
    state = state.copyWith(
      blacks: [...allBlackPieces],
      whites: [...allWhitePieces],
    );
  }

//
}

final gameMasterProvider =
    NotifierProvider<GameMasterNotifier, GameMaster>(GameMasterNotifier.new);
