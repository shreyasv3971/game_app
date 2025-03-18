import 'package:flutter/material.dart';
import 'dart:math';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class WordWhisperer extends StatefulWidget {
  const WordWhisperer({super.key});

  @override
  _WordWhispererState createState() => _WordWhispererState();
}

class _WordWhispererState extends State<WordWhisperer> {
  List<String> words = ["Apple", "Ball", "Cat", "Dog", "Egg", "Fish", "Goat", "Hat"];
  late String currentWord;
  int score = 0;
  bool isListening = false;
  late stt.SpeechToText _speech;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _setNewWord();
  }

  void _setNewWord() {
    setState(() {
      currentWord = words[Random().nextInt(words.length)];
    });
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() {
        isListening = true;
      });
      _speech.listen(onResult: (result) {
        String spokenText = result.recognizedWords.toLowerCase();
        if (spokenText == currentWord.toLowerCase()) {
          setState(() {
            score++;
          });
          _setNewWord();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Word Whisperer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Listen and Repeat:', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text(currentWord, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startListening,
              child: Text(isListening ? 'Listening...' : 'Tap to Speak'),
            ),
            SizedBox(height: 20),
            Text('Score: $score', style: TextStyle(fontSize: 24, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
