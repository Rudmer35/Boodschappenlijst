import 'package:flutter/material.dart';
import 'package:boodschappen/services/auth.dart';


class Ingredienten extends StatelessWidget {
  Ingredienten({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          backgroundColor: Colors.green[200],
          elevation: 0.0,
          title: Text('Ingredienten'),
          centerTitle: true,
          actions: <Widget>[
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signingOut();
              } ,
            )
          ],
        ), 
        
           );
        
}
}