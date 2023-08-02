import 'package:flutter_tts/flutter_tts.dart';



class TextToSpeechClass{
  FlutterTts flutterTts = FlutterTts();
  void Speak({required String text }) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.6);
    await flutterTts.setVolume(0.8);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  Future<void> Stop() async {
    await flutterTts.stop();
  }
}

