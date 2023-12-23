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

  final boardRanks = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k"];

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
                  // width: 500,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.indigo.shade50,
                        width: 10,
                      )),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            color: Colors.black,
                          ),
                          ...List.generate(
                            numberOfTileSlotOnEachAxis,
                            (index) => Container(
                              height: 30,
                              width: 50,
                              color: Colors.black,
                              child: Center(
                                  child: Text(
                                boardRanks[index],
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              ...List.generate(
                                numberOfTileSlotOnEachAxis,
                                (index) => Container(
                                  height: 50,
                                  width: 30,
                                  color: Colors.black,
                                  child: Center(
                                      child: Text(
                                    (index + 1).toString(),
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ).reversed,
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ...List.generate(
                                numberOfTileSlotOnEachAxis,
                                (yCord) => Row(
                                  children: [
                                    ...List.generate(
                                      numberOfTileSlotOnEachAxis,
                                      (xCord) {
                                        return Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: (xCord.isOdd ^ yCord.isEven)
                                                ? Colors.green
                                                : Colors.white,
                                            borderRadius: isGameBoardMidPoint(
                                                    xCord, yCord)
                                                ? const BorderRadius.all(
                                                    Radius.circular(25))
                                                : null,
                                          ),
                                          child: Stack(
                                            children: [
                                              isGameBoardMidPoint(xCord, yCord)
                                                  ? Center(
                                                      child: Container(
                                                        width: 20,
                                                        height: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              isGameBoardMidPoint(
                                                            xCord,
                                                            yCord,
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
                                                      xCord,
                                                      yCord,
                                                    ),
                                                    data: gameCoordinator
                                                        .getGamePieceByCoordinate(
                                                      xCord,
                                                      yCord,
                                                    ),
                                                    childWhenDragging:
                                                        Container(
                                                      color: Colors.pink,
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        buildGamePieceByCoordinate(
                                                          xCord,
                                                          yCord,
                                                        ),
                                                        Text("$xCord, $yCord"),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                                onAccept: (gamePiece) {
                                                  gameCoordinator
                                                      .updateLocation(
                                                    gamePiece,
                                                    xCord,
                                                    yCord,
                                                  );

                                                  setState(() {});
                                                  // delete the stupid piece
                                                },
                                                onWillAccept: (gamePiece) {
                                                  return gameCoordinator
                                                      .canPieceMoveToThisLocation(
                                                    gamePiece!,
                                                    xCord,
                                                    yCord,
                                                  );
                                                },
                                                onLeave: (data) {
                                                  //
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
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
    final gamePiece = gameCoordinator.getGamePieceByCoordinate(xCord, yCord);
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
