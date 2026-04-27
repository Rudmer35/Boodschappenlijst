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
  Future<void> deleteBoodschap(String id) async {
    await boodschappenlijst.doc(id).delete();
  }
  Future<void> deleteGroup(String naam) async {
    final snapshot = await boodschappenlijst
    .where('naam', isEqualTo: naam)
    .get();

    final batch = FirebaseFirestore.instance.batch();

    for(var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();

  }
}