// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../firebase_auth_implementation/firebase_auth_services.dart';

class SocialLoginPage extends StatefulWidget {
  const SocialLoginPage({super.key});

  @override
  State<SocialLoginPage> createState() => _SocialLoginPageState();
}

class _SocialLoginPageState extends State<SocialLoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String logo = 'assets/images/logo.png';
    String googleIcon = 'assets/images/google.png';
    String facebookIcon = 'assets/images/facebook.jpeg';
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Image.asset(logo),
              //prompt
              Text(
                "Login With",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 36,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google
                  GestureDetector(
                    child: ElevatedButton(
                      onPressed: () {
                        //using this instead of onTap
                        _signInWithGoogle();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Image.asset(
                        googleIcon,
                        width: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  //twitter
                  ElevatedButton(
                    onPressed: () {
                      signInWithFacebook();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Image.asset(
                      facebookIcon,
                      width: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }

  _signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        // Comment out the credential stuff here for production
        UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        User? user = userCredential.user;
        print("Signed in as: ${user?.displayName}");
      } else {
        print("Google Sign-In cancelled.");
      }

      Navigator.pushReplacementNamed(context, "/home");
    } catch (e) {
      print(
          "Error signing in with Google: $e"); //note: shouldn't use print in production
    }
  }

//

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Check if the login was successful
    if (loginResult.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      Navigator.pushNamed(context, "/home");
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } else {
      // Handle different cases of LoginStatus or throw an error
      throw Exception('Facebook login failed: ${loginResult.status}');
    }
  }
}
