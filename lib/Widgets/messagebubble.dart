import 'package:flutter/material.dart';
import 'package:flutter_gpt/DataBase/firebase.dart';

enum Role { human, bot }

class MessageBubble extends StatefulWidget {
  String text;
  Role type;
  String? aditionalPrompt;

  MessageBubble({required this.type, required this.text, this.aditionalPrompt});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool flag = false;
  String comment = 'Save';
  FireBaseClass fireBaseClass = new FireBaseClass();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
      child: Row(
        children: [
          Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  child: (widget.type == Role.bot)
                      ? Image.asset(
                          'Assets/Images/logo.png',
                          color: Color.fromRGBO(80, 88, 108, 1),
                          width: 40,
                          height: 40,
                        )
                      : Image.asset(
                          'Assets/Images/user.png',
                          width: 40,
                          height: 40,
                        ),
                  width: double.maxFinite,
                ),
              )),
          Expanded(
            flex: 34,
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        widget.text,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: (widget.type == Role.human)
                                ? FontWeight.w600
                                : FontWeight.w300,
                            color: Color.fromRGBO(80, 88, 108, 1)),
                      ),
                      SizedBox(height: (widget.type == Role.bot) ? 10 : 0),
                      Container(
                        child: (widget.type == Role.bot)
                            ? GestureDetector(
                                onTap: () {
                                  if (!flag) {
                                    fireBaseClass.AddingPrompt(
                                        prompt: widget.aditionalPrompt!,
                                        response: widget.text);
                                    setState(() {
                                      flag = true;
                                      comment = 'Saved';
                                    }); // not yet saved will enter
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(80, 88, 108, 1),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        (flag == false)
                                            ? Image.asset(
                                                'Assets/Images/save.png',
                                                width: 20,
                                                height: 20,
                                              )
                                            : Image.asset(
                                                'Assets/Images/bookmark.png',
                                                width: 20,
                                                height: 20,
                                              ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          comment,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  220, 226, 240, 1),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
