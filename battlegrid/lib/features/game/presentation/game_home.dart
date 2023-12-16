import 'package:battlegrid/features/game/domain/entities/game_piece.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
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
                11,
                (yIndex) => Row(
                  children: [
                    ...List.generate(
                      11,
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
                                    feedback: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.brown,
                                      child: Text("a"),
                                    ),
                                    data: GamePiece,
                                    childWhenDragging: Container(
                                      color: Colors.pink,
                                    ),
                                    child: buildGamePieceByCoordinate(
                                        xIndex, yIndex),
                                  );
                                }),
                                onAccept: (data) {},
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

  buildGamePieceByCoordinate(
    int xCord,
    int yCord,
  ) {
    return Text("${xCord + 1}, ${yCord + 1}");
  }
}
