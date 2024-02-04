import 'package:fin_trackr/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInButton extends StatelessWidget {
  final Function(OAuthCredential) onSuccess;
  final Function(String) onFailure;

  GoogleSignInButton({required this.onSuccess, required this.onFailure});

  void signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    try {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      onSuccess(credential);
    } catch (e) {
      onFailure(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: signInWithGoogle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage('assets/image/google_logo.png'),
            height: 18.0,
          ),
          SizedBox(width: 8.0),
          Text(
            'Masuk dengan Google',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}