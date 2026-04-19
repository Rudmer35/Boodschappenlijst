import 'package:boodschappen/services/boodschappen_data.dart';
import 'package:boodschappen/services/hoeveelheid_kiezen.dart';
import 'package:boodschappen/services/ingredienten_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class KeuzeIngredients {

  static void show(
   {required BuildContext context,
    required IngredientenData db,
    required BoodschappenData boodschappenDB,
    required Function(DocumentSnapshot ingredienten) onSelected,}
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height *0.9,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            )
          ),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
          
        const Padding(padding: EdgeInsets.all(16),
        child: Text(
          'Kies een ingredient', 
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ) ,
        ),
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            decoration: InputDecoration(
            hintText: "Zoek ingrediënt...",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
                 ),
                ),
               ),
              ),
        
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: db.getIngredients(), 
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('No data'));
              }
              
              final ingredients = snapshot.data!.docs;
          
              return ListView.builder(
                itemCount: ingredients.length,              
                itemBuilder: (context, index) {
                  final ingredient = ingredients[index];
          
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical:8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ), 
                    child :ListTile(
                    title: Text(ingredient['naam']),
                    subtitle: Text(ingredient['eenheid']),
                    onTap: () {
                      
                      KeuzeHoeveelheid.hoeveelHeidPopup(
                        context: context, 
                        ingredient: ingredient, onConfirm: (hoeveelheid){
                          Navigator.pop(context);
                          boodschappenDB.addBoodschappen(
                          ingredient['naam'],
                          hoeveelheid,
                          ingredient['eenheid'],
                          ''
                            );
                          },
                        );
                      
                      
                    },
                  ),
                  );
                },
              );  
            }
              ),
        )])));
      },
      );
    }
  }
  
  
  
  
  