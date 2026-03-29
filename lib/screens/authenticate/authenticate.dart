import 'package:boodschappen/screens/authenticate/register.dart';
import 'package:boodschappen/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class authenicate extends StatefulWidget {
  const authenicate({super.key});

  @override
  State<authenicate> createState() => _authenicateState();
}

class _authenicateState extends State<authenicate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Register(),
    );
  }
}