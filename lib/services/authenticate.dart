import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifeline/models/auth_user.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String str = '';
  //create user object
  AppUser _userFromFirebaseUSer(User user) {
    // str = user.uid;
    return user != null ? AppUser(uid: user.uid) : null;
  }

  String getUID() {
    return _auth.currentUser.uid;
  }

  //auth change user stream
  // String getUid(){
  //   return str;
  // }
  Stream<AppUser> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUSer(user));
  }

  //sign in with Email and Pss

  //register with email and pass
  Future register(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUSer(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUSer(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
