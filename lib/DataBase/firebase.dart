import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseClass {
  var firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference FetchEverything() {
    return firebaseFirestore.collection('Notes');
  }

  //crud Operations
  void AddingPrompt({required String prompt, required String response}) {
    DocumentReference documentReference =
        firebaseFirestore.collection('Notes').doc();
    documentReference.set({'Prompt': prompt, 'Response': response});
  }

  Future<void> DeletingPrompt({required String id}) async {
    await firebaseFirestore.collection('Notes').doc(id).delete();
  }
}
