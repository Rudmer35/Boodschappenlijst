import 'package:boodschappen/services/add_tile.dart';
import 'package:flutter/material.dart';
import 'package:boodschappen/services/keuze_ingredients.dart';
import 'package:provider/provider.dart';
import 'package:boodschappen/services/ingredienten_data.dart';
import 'package:boodschappen/services/boodschappen_data.dart';

class Boodschappenlijst extends StatefulWidget {
  const Boodschappenlijst({super.key});

  @override
  State<Boodschappenlijst> createState() => _BoodschappenlijstState();
}

class _BoodschappenlijstState extends State<Boodschappenlijst> {
  @override
  Widget build(BuildContext context) {

    final db = Provider.of<IngredientenData>(context);
    final boodschappenDb = Provider.of<BoodschappenData>(context);

    return ListView(
      children: [
        AddTile(onTap: ()=> openIngredienten(db, boodschappenDb),)
      ],
    );
  }

  void openIngredienten (IngredientenData db, BoodschappenData boodschappenDB) {
    KeuzeIngredients.show(
      context: context,
      db:db,
      boodschappenDB: boodschappenDB,
      onSelected: (ingredient){
        print(ingredient['naam']);
        print (ingredient['eenheid']);
      },);
  }

}

