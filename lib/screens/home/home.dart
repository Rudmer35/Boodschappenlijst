import 'package:boodschappen/screens/ingredienten/ingredienten.dart';
import 'package:boodschappen/services/auth.dart';
import 'package:boodschappen/services/routes.dart';
import 'package:flutter/material.dart';


class Home extends StatelessWidget {
   Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          backgroundColor: Colors.green[200],
          elevation: 0.0,
          title: Text('Menu'),
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
        body: Center(
          child: ElevatedButton(onPressed: (){          
            Navigator.pushNamed(context, Approutes.ingredienten); },
           child: Text('Ingredienten')
           ),
        ),
          );
   
  }
} 