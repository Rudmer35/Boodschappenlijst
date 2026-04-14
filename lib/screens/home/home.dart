import 'package:boodschappen/screens/boodschappen/boodschappenlijst.dart';
import 'package:boodschappen/services/auth.dart';
import 'package:flutter/material.dart';

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