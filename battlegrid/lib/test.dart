import 'package:battlegrid/features/game/presentation/game_wrapper.dart';
import 'package:flutter/material.dart';

import 'features/game/presentation/game_home.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  @override
  Widget build(BuildContext context) {
    return GameScreen();
  }
}

