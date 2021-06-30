import 'package:ami_code_pari_na/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ami_code_pari_na/models/user.dart';
class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Users _userFromFirebaseUser(User user)
  {
    if (user != null) {
      return Users(uid: user.uid);
    } else {
      return null;
    }
  }

  Stream<Users> get user{
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  Future signInWithEmailAndPassword(String email, String password)async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      await DatabaseService (uid: user.uid).updateUserData(email);
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e){
    print(e.toString());
    return null;
    }
  }
}