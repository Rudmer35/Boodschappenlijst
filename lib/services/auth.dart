import 'package:boodschappen/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

// create user object based on data from firebaseuser

CustomUser? _fromFirebaseUser(User? user){
  return user != null ? CustomUser(uid: user.uid) : null;
}

//authentication change user stream

Stream<CustomUser?> get user {
  return _auth.authStateChanges()
  .map(_fromFirebaseUser);
  
}

// sign in
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _fromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  } 
//register

// sign out
  Future signingOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}