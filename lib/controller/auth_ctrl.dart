import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> signUp(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        throw 'Mot de passe incorrect';
      } else if (e.code == 'user-not-found') {
        throw 'Utilisateur introuvable';
      } else {
        throw 'Erreur de connexion';
      }
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserCredential?> signInWithTwitter() async {
    try {
      final twitterLogin = TwitterLogin(
        apiKey: 'GmANeLThfVRqYDY4xRPi09yqp',
        apiSecretKey: '99PRg6wDPgsGLTJwHnHtHsxDJ7d4tsYCisCOJ7qahrWSoIGdVP',
        redirectURI: 'https://clstapp-f1cd7.firebaseapp.com/__/auth/handler',
        //'twitterkit-GmANeLThfVRqYDY4xRPi09yqp://',
      );
      
      final authResult = await twitterLogin.login();
      if (authResult.authToken == null) return null;
      
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );
      
      return await _auth.signInWithCredential(twitterAuthCredential);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}