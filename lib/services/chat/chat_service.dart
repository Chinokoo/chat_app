import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  //get an instance of firebase firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //get a user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //go through each individual user.
        final user = doc.data();

        //return user
        return user;
      }).toList();
    });
  }
}
