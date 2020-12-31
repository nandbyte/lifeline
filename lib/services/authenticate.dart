import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifeline/models/auth_user.dart';
import 'package:toast/toast.dart';

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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        //Toast.show(msg, context)
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
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

  static String getError(String exception) {
    switch (exception) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
        break;
      default:
        return "Login failed. Please try again.";
        break;
    }
  }
}
