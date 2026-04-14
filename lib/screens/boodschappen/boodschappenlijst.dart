import 'package:flutter/material.dart';

class Boodschappenlijst extends StatelessWidget {
    Boodschappenlijst({super.key});

final List _boodschappen = ['Wortel', 'Kaas', 'Worst', 'ei', 'Brood', 'Salami'];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 20,
          left: 20,
          right:20,
          child: ElevatedButton(
            onPressed: (){
              showDialog(
                context: context, 
                builder: (context){
                  return AlertDialog(
                    title: Text('Boodschappen toevoegen'),
                    content: SizedBox(
                      width: double.maxFinite,
                      height: 300,
                      child: ListView.builder(
                        itemCount: _boodschappen.length,
                        itemBuilder: (context, index){
                          final item = _boodschappen[index];
                      
                          return ListTile(
                            title: Text(item.toString()),
                            onTap: () {
                              print("$item geselecteerd");
                            },
                          );
                        },
                      
                      ),
                    ),
                    actions: [
                      TextButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context, 
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Nieuwe items'),
                                content: Row(
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Naam',
                                        hintText: 'Naam van item',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Eenheid',
                                        hintText: 'Naam van item',
                                        border: OutlineInputBorder(),
                                      ),
                                    )
                                  ],
                                ),
                              );
                           }); 
                          
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("Toevoegen"),
                        )
                     ],
                  );
                }
              );
            }, child: Text('Toevoegen')))
      ],
    );
  }
}