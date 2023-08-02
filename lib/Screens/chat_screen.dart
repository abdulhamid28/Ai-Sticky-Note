import 'package:flutter/material.dart';
import 'package:flutter_gpt/Completion/request_response.dart';
import 'package:flutter_gpt/DataBase/firebase.dart';
import 'package:flutter_gpt/Screens/notes_screen.dart';
import 'package:flutter_gpt/Widgets/messagebubble.dart';
import 'package:shimmer/shimmer.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Widget> Message = [];
  bool isListening = false;
  bool isPressed = false;
  String WordObtained = '';
  RequestResponse requestResponse = RequestResponse();
  SpeechToText speechToText = SpeechToText();
  FireBaseClass fireBaseClass = new FireBaseClass();
  FlutterTts flutterTts = FlutterTts();
  void Speak({required String text }) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.6);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: SizedBox(
            width: 200.0,
            height: 100.0,
            child: Shimmer.fromColors(
              baseColor: Color.fromRGBO(80, 88, 108, 1),
              highlightColor: Colors.white,
              child: Image.asset('Assets/Images/logo.png'),
            ),
          ),
        ),

        backgroundColor: Colors.white,
        //Color.fromRGBO(220, 226,240, 1),
        centerTitle: true,
        title: Text(
          'ChatGPT',
          style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Color.fromRGBO(80, 88, 108, 1)),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 630,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(220, 226, 240, 1)),
                child: SingleChildScrollView(
                  child: Column(children: Message),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AvatarGlow(
                      animate: isListening,
                      glowColor: Color.fromRGBO(80, 88, 108, 1),
                      endRadius: 55.0,
                      duration: Duration(milliseconds: 2000),
                      repeat: true,
                      showTwoGlows: true,
                      repeatPauseDuration: Duration(milliseconds: 100),
                      child: Material(
                        // Replace this child with your own
                        shape: const CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          radius: 35.0,
                          child: GestureDetector(
                            onTapDown: (someValue) async {
                              if (!isListening) {
                                await flutterTts.stop();
                                isListening = await speechToText.initialize();
                                if (isListening) {
                                  setState(() {
                                    isListening = true;
                                    speechToText.listen(onResult: (result) {
                                      WordObtained = result.recognizedWords;
                                    });
                                  });
                                }
                              }
                            },
                            onTapUp: (someValue) async {
                              setState(() {
                                isListening = false;
                                speechToText.stop();
                              });
                              if (WordObtained != '') {
                                if (WordObtained.contains('clear screen')) {
                                  setState(() {
                                    Message.clear();
                                  });
                                } else {
                                  setState(() {
                                    Message.add(MessageBubble(
                                        text: WordObtained[0].toUpperCase() +
                                            WordObtained.substring(1),
                                        type: Role.human));
                                  });
                                  String Response =
                                      await requestResponse.ApiCallForChatGpt(
                                          promtptForGpt: WordObtained.trim());
                                      Speak(text: Response);
                                  setState(() {
                                    Message.add(MessageBubble(
                                        aditionalPrompt: WordObtained[0].toUpperCase() +
                                            WordObtained.substring(1),
                                        text: Response[0].toUpperCase()+ Response.substring(1),
                                        type: Role.bot));
                                  });
                                  WordObtained = '';
                                }
                              }
                            },
                            child: Center(
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(37),
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: (isListening == false)
                                      ? Color.fromRGBO(220, 226, 240, 1)
                                      : Color.fromRGBO(80, 88, 108, 1),
                                  foregroundColor: Colors.white,
                                  child: (isListening == true)
                                      ? Icon(
                                          Icons.mic,
                                          size: 35,
                                        )
                                      : Icon(
                                          Icons.mic_none,
                                          size: 35,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(flex: 2, child: Container()),
                        Expanded(
                          flex: 6,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Shimmer.fromColors(
                              baseColor: Color.fromRGBO(80, 88, 108, 1),
                              highlightColor: Colors.red,
                              child: Text(
                                'Developed By Abdul Hamid',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                    color: Color.fromRGBO(80, 88, 108, 1)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPressed = true;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StickyNotes()));
                                  isPressed = false;
                                });
                              },
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(40),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: (isPressed == false)
                                          ? Colors.white
                                          : Color.fromRGBO(80, 88, 108, 1),
                                      borderRadius: BorderRadius.circular(40)),
                                  child: Image.asset(
                                    "Assets/Images/database.png",
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
