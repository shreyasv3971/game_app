import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';

class MemoryMatch extends StatefulWidget {
  const MemoryMatch({super.key});

  @override
  _MemoryMatchState createState() => _MemoryMatchState();
}

class _MemoryMatchState extends State<MemoryMatch> {
  List<String> allWords = ["Apple", "Ball", "Cat", "Dog", "Egg", "Fish", "Goat", "Hat", "Ice", "Jug", "Kite", "Lion", "Moon", "Nest", "Owl", "Parrot"];
  List<String> words = [];
  List<String?> grid = [];
  int level = 1;
  int gridSize = 4;
  int score = 0;
  String? firstSelected;
  int? firstIndex;
  bool waiting = false;
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _generateGrid();
  }

  void _generateGrid() {
    List<String> selectedWords = (allWords..shuffle()).take(gridSize ~/ 2).toList();
    words = [...selectedWords, ...selectedWords];
    words.shuffle();
    grid = List<String?>.filled(gridSize, null);
  }

  void _speak(String word) async {
    await flutterTts.speak(word);
  }

  void _onTileTap(int index) {
    if (waiting || grid[index] != null) return;

    setState(() {
      grid[index] = words[index];
    });

    _speak(words[index]);

    if (firstSelected == null) {
      firstSelected = words[index];
      firstIndex = index;
    } else {
      if (firstSelected == words[index] && firstIndex != index) {
        score++;
        firstSelected = null;
        firstIndex = null;

        if (grid.every((element) => element != null)) {
          _levelUp();
        }
      } else {
        waiting = true;
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            grid[firstIndex!] = null;
            grid[index] = null;
            firstSelected = null;
            firstIndex = null;
            waiting = false;
          });
        });
      }
    }
  }

  void _levelUp() {
    if (gridSize < 64) {
      setState(() {
        level++;
        gridSize *= 2;
        _generateGrid();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Memory Match - Level $level')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Score: $score', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: sqrt(gridSize).toInt(),
                childAspectRatio: 1.0,
              ),
              itemCount: gridSize,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _onTileTap(index),
                  child: Card(
                    color: grid[index] != null ? Colors.blueAccent : Colors.grey,
                    child: Center(
                      child: Text(
                        grid[index] ?? "",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
