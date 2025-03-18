import 'package:flutter/material.dart';
import 'memory_match.dart';
import 'word_whisperer.dart';

class GameSelectionScreen extends StatelessWidget {
  const GameSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game Selection')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryMatch()),
                );
              },
              child: Text('Memory Match Game'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordWhisperer()),
                ),
              child: Text('Word Whisperer'),
            ),
          ],
        ),
      ),
    );
  }
}
