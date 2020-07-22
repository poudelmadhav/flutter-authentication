import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:madhav_auth/models/user.dart';
import 'package:madhav_auth/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // create user obj based on FirebaseUser
  User _userFromFirebaseUSer(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUSer);
  }

  // sign in anonymosly
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUSer(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;
      return _userFromFirebaseUSer(user);
    } catch (e) {
      print(e.toString());
      return e.message;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;

      // create a new document for the user with uid
      await DatabaseService(uid: user.uid).updateUserData('0', name, 100);
      return _userFromFirebaseUSer(user);
    } catch (e) {
      print(e.toString());
      return e.message;
    }
  }

  // sign out
  Future signOut() async {
    try {
      await _googleSignIn.signOut();
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with google
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final AuthResult result = await _auth.signInWithCredential(credential);
      final FirebaseUser user = result.user;

      // create a new document for the user with uid
      await DatabaseService(uid: user.uid)
          .updateUserData('0', user.displayName, 100);
      return _userFromFirebaseUSer(user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
