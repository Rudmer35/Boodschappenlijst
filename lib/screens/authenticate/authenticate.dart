import 'package:boodschappen/screens/authenticate/register.dart';
import 'package:boodschappen/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenicate extends StatefulWidget {
  const Authenicate({super.key});

  @override
  State<Authenicate> createState() => _AuthenicateState();
}

class _AuthenicateState extends State<Authenicate> {

  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn
    );
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    }else{
      return Register(toggleView: toggleView);
    }
  }
}