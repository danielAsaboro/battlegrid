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
        body: Container(
          color: Colors.amber,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            color: (xIndex.isOdd ^ yIndex.isEven)
                                ? Colors.green
                                : Colors.white,
                            child: Center(
                              child: DragTarget<GamePiece>(
                                builder:
                                    ((context, candidateData, rejectedData) {
                                  return Draggable(
                                    feedback: buildGamePieceByCoordinate(
                                      xIndex,
                                      yIndex,
                                    ),
                                    data: GamePiece,
                                    childWhenDragging: Container(
                                      color: Colors.pink,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: buildGamePieceByCoordinate(
                                        xIndex,
                                        yIndex,
                                      ),
                                    ),
                                  );
                                }),
                                onAccept: (data) {
                                  setState(() {});
                                },
                                onWillAccept: (data) {
                                  print("accepted lol");
                                  return true;
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 700,
                height: 50,
                child: Row(
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text("Undo Moves")),
                    ElevatedButton(onPressed: () {}, child: Text("Skip Turn")),
                    ElevatedButton(
                        onPressed: () {}, child: Text("Export Moves")),
                    ElevatedButton(
                        onPressed: () {}, child: Text("Import Moves")),
                    ElevatedButton(
                        onPressed: () {}, child: Text("Restart Game")),
                  ],
                ),
              ),
            ],
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
        : const SizedBox.shrink();
  }
}
