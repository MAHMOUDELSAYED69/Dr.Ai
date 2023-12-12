import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'package:flutter/services.dart';
// Future signInWithGoogle() async {
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//   if (googleUser == null) return;

//   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );

//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }
// Future<UserCredential> signInWithGoogle() async {
//   try {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     if (googleUser == null) {
//       throw FirebaseAuthException(
//         code: 'user-cancelled',
//         message: 'User cancelled Google Sign-In',
//       );
//     }
//     final GoogleSignInAuthentication googleAuth =
//         await googleUser.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//     final UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithCredential(credential);

//     return userCredential;
//   } catch (e) {
//     log('Error signing in with Google: $e');
//     rethrow;
//   }
// }

Future<UserCredential?> signInWithGoogle() async {
  try {
    // Initialize GoogleSignIn
    GoogleSignIn googleSignIn =
        GoogleSignIn(scopes: ["https://www.googleapis.com/auth/drive"]);

    // Attempt to sign in with Google
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Check if the user canceled the sign-in process
    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'user-cancelled',
        message: 'User cancelled Google Sign-In',
      );
    }

    // Obtain the GoogleSignInAuthentication object
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a Firebase credential using the GoogleAuth
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the created credential
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // Return the user credential if sign-in is successful
    return userCredential;
  } on FirebaseAuthException catch (e) {
    // Handle FirebaseAuth related exceptions
    log('FirebaseAuthException: ${e.message}');
    return null;
  } on PlatformException catch (e) {
    // Handle other platform exceptions
    log('PlatformException: ${e.message}');
    return null;
  } catch (e) {
    // Handle other exceptions
    log('Error signing in with Google: $e');
    return null;
  }
}
