import 'package:cloud_firestore/cloud_firestore.dart';

class IngredientenData {
  final String uid;

  IngredientenData({required this.uid});

  final CollectionReference users =
    FirebaseFirestore.instance.collection('Gebruikers');

  Future addIngredient (String naam, String unit) async {
    return await users
      .doc(uid)
      .collection('ingredienten')
      .add({
        'naam': naam,
        'eenheid': unit,
        'aangemaaktOp': Timestamp.now(),      
      });
}

  Stream<QuerySnapshot> getIngredients() {
  return users
      .doc(uid)
      .collection('ingredienten')
      .orderBy('naam') // 👈 sort alphabetically
      .snapshots();
}
}