import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      print('Début connexion Google...');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('Utilisateur a annulé la connexion Google');
        throw 'Connexion Google annulée';
      }

      print('Utilisateur Google récupéré: ${googleUser.email}');
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      print('Tokens récupérés - AccessToken: ${googleAuth.accessToken != null}, IdToken: ${googleAuth.idToken != null}');
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print('Tentative de connexion Firebase...');
      final result = await _auth.signInWithCredential(credential);
      print('Connexion Google réussie!');
      return result;
    } catch (e) {
      print('Erreur Google Sign-In: $e');
      if (e.toString().contains('popup_closed')) {
        throw 'Connexion Google annulée';
      }
      throw 'Erreur de connexion Google: $e';
    }
  }

  Future<UserCredential?> signInWithTwitter() async {
    try {
      print('Début connexion Twitter...');
      TwitterAuthProvider twitterProvider = TwitterAuthProvider();
      final result = await _auth.signInWithProvider(twitterProvider);
      print('Connexion Twitter réussie!');
      return result;
    } catch (e) {
      print('Erreur Twitter Sign-In: $e');
      throw 'Erreur de connexion Twitter: $e';
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}