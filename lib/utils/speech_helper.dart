import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:async';
import 'dart:io';

class SpeechHelper {
  late stt.SpeechToText _speech;
  bool isListening = false;

  SpeechHelper() {
    _speech = stt.SpeechToText();
  }

  void speakWord(String word) {
    if (Platform.isAndroid || Platform.isIOS) {
      String command = Platform.isAndroid
          ? 'termux-tts "$word"' // For Android (using Termux, if available)
          : 'say "$word"'; // For iOS/macOS

      Process.run(command, [], runInShell: true);
    } else {
      print("Text-to-speech is only supported on Android and iOS.");
    }
  }

  Future<String?> listenForWord() async {
    Completer<String?> completer = Completer();
    bool available = await _speech.initialize();
    if (available) {
      isListening = true;
      _speech.listen(onResult: (result) {
        isListening = false;
        completer.complete(result.recognizedWords);
      });
    } else {
      completer.complete(null);
    }
    return completer.future;
  }
}