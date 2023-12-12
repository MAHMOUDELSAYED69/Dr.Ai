import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'package:flutter/services.dart';
class GoogleService {
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn =
          GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'user-cancelled',
          message: 'User cancelled Google Sign-In',
        );
      }
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.message}');
      return null;
    } on PlatformException catch (e) {
      log('PlatformException: ${e.message}');
      return null;
    } catch (e) {
      log('Error signing in with Google: $e');
      return null;
    }
  }
}
