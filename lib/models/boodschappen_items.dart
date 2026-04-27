import 'package:cloud_firestore/cloud_firestore.dart';


class Boodschap {
  final String id;
  final String naam;
  final int hoeveelheid;
  final String eenheid;
  final String maaltijd;
  
  Boodschap({
    required this.id,
    required this.naam,
    required this.hoeveelheid,
    required this.eenheid,
    required this.maaltijd
  });

  factory Boodschap.fromDoc(DocumentSnapshot doc) {

    final data = doc.data() as Map<String, dynamic>;

    return Boodschap(
      id:doc.id,
      naam: (data['naam'] ?? '').toString(),
      hoeveelheid: (data['hoeveelheid'] ?? 0) as int,
      eenheid: (data['eenheid'] ?? '').toString(),
      maaltijd: (data['maaltijd'] ?? '').toString(),
      );
      
  }
}