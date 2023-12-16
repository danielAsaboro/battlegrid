import 'package:battlegrid/features/game/presentation/game_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameScreenWrapper extends ConsumerStatefulWidget {
  const GameScreenWrapper({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GameScreenWrapperState();
}

class _GameScreenWrapperState extends ConsumerState<GameScreenWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 500,
        child: Column(
          children: [
            GameScreen(),
            SizedBox(
              width: 400,
              height: 50,
              child: Row(
                children: [
                  ElevatedButton(onPressed: () {}, child: Text("Undo Moves")),
                  ElevatedButton(onPressed: () {}, child: Text("Skip Turn")),
                  ElevatedButton(onPressed: () {}, child: Text("Export Moves")),
                  ElevatedButton(onPressed: () {}, child: Text("Import Moves")),
                  ElevatedButton(onPressed: () {}, child: Text("Restart Game")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
