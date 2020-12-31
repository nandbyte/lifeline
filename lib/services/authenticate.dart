import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  String uid;
  
  Future<void> regestration(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      //signIn(email,password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'Weak-password')
        print('Password is weak');
      else if (e.code == 'email-already-in-use')
        print('The account already exists');
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found')
        print("NO user found for that email");
      else if (e.code == 'wrong-password') print('Wrong password!!');
    }
  }

  String getUID(){
    User user = FirebaseAuth.instance.currentUser;
    final _uid = user.uid;
    this.uid = _uid;
    return uid;
  }
}
