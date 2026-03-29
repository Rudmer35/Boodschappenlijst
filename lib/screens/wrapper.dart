import 'package:boodschappen/models/user.dart';
import 'package:boodschappen/screens/authenticate/authenticate.dart';
import 'package:boodschappen/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class wrapper extends StatelessWidget {
  const wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser?>(context);
    

    // return home or authenticate
    if (user == null) {
      return authenicate();
    } else {
      return Home();    
    }
  }
}