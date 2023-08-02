import 'package:flutter/material.dart';
import 'package:flutter_gpt/DataBase/firebase.dart';

class NoteCapsule extends StatefulWidget {
  String prompt;

  String response;

  String docId;

  NoteCapsule(
      {required this.prompt, required this.response, required this.docId});

  @override
  State<NoteCapsule> createState() => _NoteCapsuleState();
}

class _NoteCapsuleState extends State<NoteCapsule> {
  FireBaseClass fireBaseClass = new FireBaseClass();

  void TriggerBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 50, 10, 50),
            child: Center(
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 900,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.response,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 17,
                                color: Color.fromRGBO(80, 88, 108, 1)),
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(220, 226, 240, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 10, 10, 10),
                child: Text(
                  widget.prompt,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color.fromRGBO(80, 88, 108, 1)),
                ),
              ),
              width: double.maxFinite,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      TriggerBottomSheet(context: context);
                    },
                    child: Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'Assets/Images/book.png',
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Read More',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      height: 40,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(80, 88, 108, 1),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20))),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await fireBaseClass.DeletingPrompt(id: widget.docId);
                    },
                    child: Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'Assets/Images/bin.png',
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Delete',
                              style: TextStyle(
                                  color: Color.fromRGBO(80, 88, 108, 1),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      height: 40,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20))),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
