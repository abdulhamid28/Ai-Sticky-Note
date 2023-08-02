import 'package:flutter/material.dart';
import 'package:flutter_gpt/Screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HeadQuaters());
}

class HeadQuaters extends StatefulWidget {
  const HeadQuaters({super.key});

  @override
  State<HeadQuaters> createState() => _HeadQuatersState();
}

class _HeadQuatersState extends State<HeadQuaters> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(canvasColor: Colors.transparent),
      home: ChatScreen(),
    );
  }
}
