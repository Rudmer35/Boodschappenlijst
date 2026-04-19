import 'package:boodschappen/services/add_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

        return Column(
      children: [

        AddTile(
          onTap: () => openIngredienten(db, boodschappenDb),
        ),

        const SizedBox(height: 10),

        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: boodschappenDb.getBoodschappen(),
            builder: (context, snapshot) {

              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final items = snapshot.data!.docs;

              if (items.isEmpty) {
                return const Center(
                  child: Text('Geen boodschappen'),
                );
              }

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {

                  final item = items[index];

                  return ListTile(
                    title: Text(item['naam']),
                    subtitle: Text(
                      "${item['hoeveelheid']} ${item['eenheid']}"
                    ),
                    trailing: Text(item['maaltijd']),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void openIngredienten(
    IngredientenData db,
    BoodschappenData boodschappenDB,
  ) {
    KeuzeIngredients.show(
      context: context,
      db: db,
      boodschappenDB: boodschappenDB,
      onSelected: (ingredient) {
        print(ingredient['naam']);
        print(ingredient['eenheid']);
      },
    );
  }
}
               