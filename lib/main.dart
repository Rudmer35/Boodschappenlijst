import 'package:boodschappen/models/user.dart';
import 'package:boodschappen/screens/wrapper.dart';
import 'package:boodschappen/services/auth.dart';
import 'package:boodschappen/services/boodschappen_data.dart';
import 'package:boodschappen/services/ingredienten_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:boodschappen/services/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [StreamProvider<CustomUser?>.value(
      value: AuthService().user,
      initialData: null,),
      ProxyProvider<CustomUser?, IngredientenData?>(
        update: (_, user, _){
        if (user == null) return null;
        return IngredientenData(uid: user.uid!);
      }),
      ProxyProvider<CustomUser?, BoodschappenData?>(
        update: (_, user, _){
          if (user == null) return null;
          return BoodschappenData(uid: user.uid!);
        })

      ],    
        child: MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
          ),
        routes: {
        Approutes.wrapper: (context) => Wrapper(),
       
      },     
      ),
    );
  }
}