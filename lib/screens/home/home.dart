import 'package:boodschappen/screens/boodschappen/boodschappenlijst.dart';
import 'package:boodschappen/services/auth.dart';
import 'package:boodschappen/services/ingredienten_data.dart';
import 'package:flutter/material.dart';
import 'package:boodschappen/screens/boodschappen/toevoegeningredienten.dart';
import 'package:provider/provider.dart';
import 'package:boodschappen/models/user.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Boodschappenlijst(),
    Center(child: Text("Items Page")),
    Center(child: Text("Settings Page")),
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    if(user == null){
      return const Center(
        child: Text('Geen gebruiker ingelogd'),
      );
    }

    final db = IngredientenData(uid: user.uid!);

    return Scaffold(
      backgroundColor: Colors.green[50],

      appBar: AppBar(
        backgroundColor: Colors.green[200],
        elevation: 0.0,
        title: const Text('Boodschappen'),
        centerTitle: true,
        actions: <Widget>[
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            icon: const Icon(Icons.person),
            label: const Text('Logout'),
            onPressed: () async {
              await _auth.signingOut();
            },
          )
        ],        
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green[200]),
              child: Center(
                child: Text('Menu',
                style: TextStyle(color: Colors.black, fontSize: 24),),
              )),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Nieuw Ingredient'),
                onTap: () {
                  showAddIngredientDialog(context, db);
                },
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: const Text('Nieuwe Maaltijd'),
                onTap: () {},
              )
          ],
        ),
      ),

      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.local_grocery_store_outlined),
            selectedIcon: Icon(Icons.local_grocery_store),
            label: "Boodschappen",
          ),
          NavigationDestination(
            icon: Icon(Icons.dining_outlined),
            selectedIcon: Icon(Icons.dining),
            label: "Maaltijden",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}