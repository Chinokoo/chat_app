import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    //signing in with email and password
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    }
    //catching errors during login process
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

//sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    //creating a new user with email and password
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    }
    //catching errors during sign up process
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

//sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }
//errors
}
