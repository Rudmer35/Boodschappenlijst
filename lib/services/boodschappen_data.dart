import 'package:cloud_firestore/cloud_firestore.dart';

class BoodschappenData {
  final String uid;

  BoodschappenData({required this.uid });

 CollectionReference get boodschappenlijst => 
    FirebaseFirestore.instance
    .collection('Gebruikers')
    .doc(uid)
    .collection('boodschappen');

  Stream<QuerySnapshot> getBoodschappen() {
  return boodschappenlijst.snapshots();
  }

  Future<void> addBoodschappen (String naam, int hoeveelheid, String eenheid, String maaltijd) async{
       await boodschappenlijst.add({
      'naam': naam,
      'hoeveelheid': hoeveelheid,
      'eenheid': eenheid,
      'maaltijd': maaltijd,
      });
  }

}