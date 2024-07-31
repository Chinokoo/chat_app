import 'package:chat_app/errors/error_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of auth and firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    //signing in with email and password
    try {
      //create user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      //save user in a separate doc
      firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': userCredential.user!.email,
      });
      return userCredential;
    }
    //catching errors during login process
    on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      ErrorHandler.showError(context, errorMessage);
    }
  }

//sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    //creating a new user with email and password
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      //save user in a separate doc
      firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': userCredential.user!.email,
      });
      return userCredential;
    }
    //catching errors during sign up process
    on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      ErrorHandler.showError(context, errorMessage);
    }
  }

//sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }
//errors
}
