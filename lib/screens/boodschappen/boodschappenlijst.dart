import 'package:flutter/material.dart';
import 'package:boodschappen/services/database.dart';
import 'package:boodschappen/models/user.dart';
import 'package:provider/provider.dart';
import 'package:boodschappen/screens/boodschappen/toevoegeningredienten.dart';

class Boodschappenlijst extends StatelessWidget {
     Boodschappenlijst({super.key});

  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    if(user == null){
      return const Center(
        child: Text('Geen gebruiker ingelogd'),
      );
    }

    final db = DatabaseService(uid: user.uid);

    return FloatingActionButton(
  onPressed: () {
    showAddIngredientDialog(context, db);
  },
  child: const Icon(Icons.add),
);
  }
}