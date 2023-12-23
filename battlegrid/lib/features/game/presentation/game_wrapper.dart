import 'package:battlegrid/shared/presentation/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameButtons extends ConsumerStatefulWidget {
  const GameButtons({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GameScreenWrapperState();
}

class _GameScreenWrapperState extends ConsumerState<GameButtons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: Column(
              children: [
                Row(
                  children: [
                    AppButton(onPressed: () {}, child: const Text("Undo Moves")),
                    AppButton(onPressed: () {}, child: const Text("Skip Turn")),
                    AppButton(onPressed: () {}, child: const Text("Export Moves")),
                  ],
                ),
                Row(
                  children: [
                    AppButton(onPressed: () {}, child: const Text("Import Moves")),
                    AppButton(onPressed: () {}, child: const Text("Restart Game")),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
