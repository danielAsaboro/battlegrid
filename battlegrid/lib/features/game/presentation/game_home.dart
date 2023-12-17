import 'package:battlegrid/core/constants/game_setting_constants.dart';
import 'package:battlegrid/features/game/domain/entities/game_piece.dart';
import 'package:battlegrid/features/game/infrastructure/repo/game_master.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  final gameCoordinator = GameMaster.newGame();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // GameBoard
                Container(
                  width: 500,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 10,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...List.generate(
                        numberOfTileSlotOnEachAxis,
                        (yIndex) => Row(
                          children: [
                            ...List.generate(
                              numberOfTileSlotOnEachAxis,
                              (xIndex) {
                                return Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: (xIndex.isOdd ^ yIndex.isEven)
                                          ? Colors.green
                                          : Colors.white,
                                      borderRadius:
                                          isGameBoardMidPoint(xIndex, yIndex)
                                              ? const BorderRadius.all(
                                                  Radius.circular(25))
                                              : null,
                                    ),
                                    child: Stack(
                                      children: [
                                        isGameBoardMidPoint(xIndex, yIndex)
                                            ? Center(
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        isGameBoardMidPoint(
                                                      xIndex,
                                                      yIndex,
                                                    )
                                                            ? const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    15))
                                                            : null,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                        DragTarget<GamePiece>(
                                          builder: ((
                                            context,
                                            candidateData,
                                            rejectedData,
                                          ) {
                                            return Draggable<GamePiece>(
                                              feedback:
                                                  buildGamePieceByCoordinate(
                                                xIndex,
                                                yIndex,
                                              ),
                                              data: gameCoordinator
                                                  .buildGamePieceByCoordinate(
                                                xIndex,
                                                yIndex,
                                              ),
                                              childWhenDragging: Container(
                                                color: Colors.pink,
                                              ),
                                              child: buildGamePieceByCoordinate(
                                                xIndex,
                                                yIndex,
                                              ),
                                            );
                                          }),
                                          onAccept: (piece) {
                                            gameCoordinator.updateLocation(
                                              piece,
                                              xIndex,
                                              yIndex,
                                            );
                                            setState(() {});
                                          },
                                          onWillAccept: (data) {
                                            print("accepted lol");
                                            return true;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // GameButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGamePieceByCoordinate(
    int xCord,
    int yCord,
  ) {
    final gamePiece = gameCoordinator.buildGamePieceByCoordinate(xCord, yCord);
    return gamePiece != null
        ? SvgPicture.asset(
            gamePiece.imageSourcePath,
            width: 50,
            height: 50,
          )
        : const SizedBox(
            width: 50,
            height: 50,
          );
  }

  bool isGameBoardMidPoint(int xIndex, int yIndex) {
    const midPoint = (numberOfTileSlotOnEachAxis - 1) / 2;
    if (xIndex == midPoint && yIndex == midPoint) return true;
    return false;
  }
}
