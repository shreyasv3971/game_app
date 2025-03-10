import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accessible Language Learning',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameSelectionScreen()),
                );
              },
              child: Text('Start Learning'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Accessibility Settings'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Profile & Progress'),
            ),
          ],
        ),
      ),
    );
  }
}

class GameSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game Selection')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('Tic Tac Toe'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Word Whisperer'),
            ),
          ],
        ),
      ),
    );
  }
}
