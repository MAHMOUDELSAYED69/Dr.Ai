// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<void> storeUserData({
    // required String email,
    // required String uid,
    required String name,
    required String phoneNumber,
    required String dob,
    required String gender,
    required String bloodType,
    required String height,
    required String weight,
    required String chronicDiseases,
    required String familyHistoryOfChronicDiseases,
  }) async {
    Map<String, dynamic> userData = {
      'isActive': true,
      'date': DateTime.now().toString(),
      'email': _auth.currentUser!.email,
      'uid': _auth.currentUser!.uid,
      'name': name,
      'phoneNumber': phoneNumber,
      'dob': dob,
      'gender': gender,
      'bloodType': bloodType,
      'height': height,
      'weight': weight,
      'chronicDiseases': chronicDiseases,
      'familyHistoryOfChronicDiseases': familyHistoryOfChronicDiseases,
    };

    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .set(userData);
  }

  //! REGISTER
  static Future<void> register(
      {required String email,
      required String password,
      required String displayName}) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await FirebaseAuth.instance.currentUser!.updateDisplayName(displayName);
    FirebaseService.emailVerify();
    FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'uid': userCredential.user!.uid,
      'email': userCredential.user!.email,
      'name': userCredential.user!.displayName,
      //  'image': userCredential.user?.photoURL,
      'time': DateTime.now().toString(),
    });
  }

  // Future<void> renameDocument() async {
  //   final Map<String, dynamic> userData = CacheData.getMapData(key: "userData");
  //   final firestore = FirebaseFirestore.instance;

  //   final userDocRef = firestore.collection('users').doc(userData['uid']);
  //   final originalDocSnapshot = await userDocRef.get();
  //   final data = originalDocSnapshot.data();

  //   if (data != null) {
  //     final newDocRef = firestore.collection('users').doc('account_deprecated');
  //     await newDocRef.set(data);
  //     await userDocRef.delete();

  //     log('Document renamed successfully!');
  //   } else {
  //     log('Original document not found.');
  //   }
  // }

//! LOGIN
  static Future<void> logIn(
      {required String email, required String password}) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'uid': userCredential.user!.uid,
      'email': userCredential.user!.email,
      'name': userCredential.user!.displayName,
      //   'image': userCredential.user?.photoURL,
      'time': DateTime.now().toString(),
    }, SetOptions(merge: true));
  }

  //! RESET PASSWORD
  static Future<void> resetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  //! LOG OUT
  static Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //! EMAIL VERIFY
  static Future<void> emailVerify() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  //! DELETE USER
  static Future<void> deleteUser(
      {required String email, required String password}) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final User? user = firebaseAuth.currentUser;
    if (user != null) {
      try {
        AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );

        await user.reauthenticateWithCredential(credential);
        await user.delete();
        log('User account deleted successfully.');
      } catch (e) {
        log('An error occurred while deleting the user account: $e');
      }
    } else {
      log('No user is currently signed in.');
    }
  }

//! CHANGE EMAIL
  static Future<void> changeEmail(String newEmail) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      if (!user.emailVerified) {
        log("Please verify the new email before changing email.");
        return;
      }

      await user.updateEmail(newEmail);
      log("Email address updated successfully");
    } catch (error) {
      log("Error updating email: $error");
    }
  }

//! CHANGE EMAIL WITH REAUTH
  static Future<void> updateEmailWithReauth(
      {required String newEmail, required String password}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: password);
        await user.reauthenticateWithCredential(credential);

        await user.updateEmail(newEmail);
        log("Email updated successfully to $newEmail");
      } else {
        log("User not signed in.");
      }
    } catch (e) {
      log("Error updating email: $e]");
    }
  }

  static Future<void> updateUserImage({String? urlImage}) async {
    await FirebaseAuth.instance.currentUser!.updatePhotoURL(urlImage);
    log(FirebaseAuth.instance.currentUser!.photoURL.toString());
  }

  static Future<void> updateUserDisplayName({String? name}) async {
    await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
    log(FirebaseAuth.instance.currentUser!.displayName.toString());
  }
}
