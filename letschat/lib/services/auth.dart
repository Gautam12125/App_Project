import 'package:letschat/modal/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  People _userFromfirebaseUser(UserCredential userCredential) {
    return userCredential != null
        ? People(userId: _auth.currentUser.uid)
        : null;
  }

  Future signINWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      UserCredential userCredential = result.user as UserCredential;
      var userfromfirebaseUser = _userFromfirebaseUser(userCredential);
      return userfromfirebaseUser;
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserCredential userCredential = result.user as UserCredential;
      return _userFromfirebaseUser(userCredential);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {}
  }
}
