import 'package:boodschappen/models/eenheden.dart';
import 'package:flutter/material.dart';
import 'package:boodschappen/services/ingredienten_data.dart';

Future<void> showAddIngredientDialog(
  BuildContext context,
  IngredientenData db,
) async {
  final TextEditingController naamController = TextEditingController();
  String? geselecteerdeEenheid;

  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("Ingredient toevoegen"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: naamController,
                  decoration: const InputDecoration(labelText: "Naam"),
                ),
                const SizedBox(height: 10),

                DropdownButtonFormField<String>(
                  value: geselecteerdeEenheid,
                  items: Eenheden.Lijst.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      geselecteerdeEenheid = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Eenheid",
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Annuleren"),
              ),
              ElevatedButton(
                onPressed: () {
                  final naam = naamController.text;
                  final eenheid = geselecteerdeEenheid;

                  if (naam.isNotEmpty && eenheid != null) {
                    db.addIngredient(naam, eenheid);
                    Navigator.pop(context);
                  }
                },
                child: const Text("Opslaan"),
              ),
            ],
          );
        },
      );
    },
  );
}
