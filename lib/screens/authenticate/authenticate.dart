import 'package:boodschappen/screens/authenticate/register.dart';
import 'package:boodschappen/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class authenicate extends StatefulWidget {
  const authenicate({super.key});

  @override
  State<authenicate> createState() => _authenicateState();
}

class _authenicateState extends State<authenicate> {

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