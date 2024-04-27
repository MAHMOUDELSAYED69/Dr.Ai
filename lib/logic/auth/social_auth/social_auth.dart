import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum SocialAuthState { initial, authenticated, unauthenticated }

class SocialAuthCubit extends Cubit<SocialAuthState> {
  SocialAuthCubit() : super(SocialAuthState.initial);

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      emit(SocialAuthState.authenticated);
    } catch (e) {
      emit(SocialAuthState.unauthenticated);
    }
  }

  void signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await _firebaseAuth.signInWithCredential(facebookAuthCredential);
      emit(SocialAuthState.authenticated);
    } catch (e) {
      emit(SocialAuthState.unauthenticated);
    }
  }

  void signInWithApple() async {
    try {
      final appleCredential =
          await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      await _firebaseAuth.signInWithCredential(oauthCredential);
      emit(SocialAuthState.authenticated);
    } catch (e) {
      emit(SocialAuthState.unauthenticated);
    }
  }
}
