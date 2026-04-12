import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  
  final String? uid;
  DatabaseService({this.uid});

  // Colletion reference
  final CollectionReference Userdata = FirebaseFirestore.instance.collection('Gebruikers');

  Future updateUserDate (String naam, String email) async {
    return await Userdata.doc(uid).set({
      'naam': naam,
      'email': email,
    });

  }

  // get User stream

  Stream<QuerySnapshot> get users {
    return Userdata.snapshots();
  }
}