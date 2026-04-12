import 'package:boodschappen/models/user.dart';
import 'package:boodschappen/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

// create user object based on data from firebaseuser

CustomUser? _fromFirebaseUser(User? user){
  return user != null ? CustomUser(uid: user.uid, email: user.email) : null;
}

//authentication change user stream

Stream<CustomUser?> get user {
  return _auth.authStateChanges()
  .map(_fromFirebaseUser);
  
}

// sign in anon
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

//sign in with email and password

 Future signInWithEmailAndPassword(String email, String password) async {
  try{
    UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = result.user;

  
    return _fromFirebaseUser(user);
  }catch(e){
    print(e.toString());
    return null;
  }

}

//register with email and password

Future registerWithEmailAndPassword(String email, String password) async {
  try{
    UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User? user = result.user;

    // Create new document for the user with uid
    if (user != null) {
    await DatabaseService(uid: user.uid).updateUserDate('Nieuwe Gebruiker', user.email ?? '');
    }

    return _fromFirebaseUser(user);
  }catch(e){
    print(e.toString());
    return null;
  }

}

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