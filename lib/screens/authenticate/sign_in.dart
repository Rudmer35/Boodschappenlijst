import 'package:boodschappen/services/auth.dart';
import 'package:boodschappen/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:boodschappen/shared/constant.dart';

class SignIn extends StatefulWidget {
  final Function? toggleView;
  const SignIn({super.key, this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

final AuthService _auth = AuthService();
final _formKey = GlobalKey<FormState>();
bool loading = false;

// text field state

String email = '';
String password = '';
String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        elevation: 0.0,
        title: Text('Sign in'),
        centerTitle: true,
        actions: <Widget>[
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView?.call();
            },
            )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
               SizedBox(height: 20.0,),
               TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => (val == null || val.isEmpty) ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
               ),
               SizedBox(height: 20.0,),
               TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => (val == null || val.length < 6) ? 'Password not compatible' : null,
                obscureText: true,
                onChanged: (val) {
                   setState(() => password = val);
                },
               ),
               SizedBox(height: 20.0,),
               ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[200]
                ),
                onPressed:() async {
                  if (_formKey.currentState?.validate() ?? false){
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null){
                      setState(() { 
                        loading = false;
                        error = 'Email or password not correct';});
                    }
                  }
                }, 
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 12.0,),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0,),
                )
            ],
          ),
        ),
      ),
    );
  }
}