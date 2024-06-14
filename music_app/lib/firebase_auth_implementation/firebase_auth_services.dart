// ignore_for_file: avoid_print, prefer_final_fields, unused_catch_clause

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print("Some error occured");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print("Some error occured");
    }
    return null;
  }

  signInWithGoogle() async {
    // begin sign in provess
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    // get auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //create new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //sign in user with the credential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
