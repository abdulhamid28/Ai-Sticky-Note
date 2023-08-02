import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gpt/DataBase/firebase.dart';
import 'package:flutter_gpt/Widgets/notescapsule.dart';
import 'package:shimmer/shimmer.dart';

class StickyNotes extends StatefulWidget {
  const StickyNotes({super.key});

  @override
  State<StickyNotes> createState() => _StickyNotesState();
}

class _StickyNotesState extends State<StickyNotes> {
  FireBaseClass fireBaseClass = new FireBaseClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Image.asset('Assets/Images/database.png'),
            ),
          ),
        ),

        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Sticky Notes',
          style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Color.fromRGBO(80, 88, 108, 1)),
        ),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: fireBaseClass.FetchEverything().snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> querysnapshot) {
          if (querysnapshot.hasData && querysnapshot.data!.docs.length != 0) {
            print('length : ${querysnapshot.data!.docs.length}');
            return ListView.builder(
                itemCount: querysnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = querysnapshot.data!.docs[index];
                  return NoteCapsule(
                    prompt: data['Prompt'],
                    response: data['Response'],
                    docId: data.id,
                  );
                });
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 10,
                  color: Color.fromRGBO(80, 88, 108, 1),
                )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Searching',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(80, 88, 108, 1)),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
