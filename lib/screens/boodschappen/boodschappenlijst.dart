import 'package:boodschappen/services/add_tile.dart';
import 'package:boodschappen/services/grouping.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:boodschappen/services/keuze_ingredients.dart';
import 'package:provider/provider.dart';
import 'package:boodschappen/services/ingredienten_data.dart';
import 'package:boodschappen/services/boodschappen_data.dart';
import 'package:boodschappen/models/boodschappen_items.dart';

class Boodschappenlijst extends StatefulWidget {
  const Boodschappenlijst({super.key});

  @override
  State<Boodschappenlijst> createState() => _BoodschappenlijstState();
}

class _BoodschappenlijstState extends State<Boodschappenlijst> {
   final Grouping grouping = Grouping();
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

              final allItems = snapshot.data!.docs
              .map((doc) => Boodschap.fromDoc(doc))
              .toList();

              final grouped = grouping.group(allItems);
              
              if (grouped.isEmpty) {
                return const Center(
                  child: Text('Geen boodschappen'),
                );
              }
              return ListView(
                children: grouped.entries.map((entry){
                  final naam = entry.key;
                  final groupItems = entry.value;

                  final total = groupItems.fold<int>(0,
                (sum, item)=> sum + item.hoeveelheid,
                );

                 return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          naam,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Totaal: $total"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete_forever, color: Colors.red),
              onPressed: () {
                boodschappenDb.deleteGroup(naam);
                },
              ),
              const Icon(Icons.expand_more)
          ],
        ),

        children: groupItems.map((item) {
          return ListTile(
            title: Text(item.maaltijd.isEmpty
                ? item.naam
                : item.maaltijd),

            subtitle: Text(item.eenheid),

            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${item.hoeveelheid}"),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    boodschappenDb.deleteBoodschap(item.id);
                  },
                  ),
                  
              ],
            ),
            );
           }).toList(),
            ),
          );
            }).toList(),
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
               