import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'myScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Aplikasi CRUD',
        theme: new ThemeData(primarySwatch: Colors.blue),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignin = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleAcc = await GoogleSignIn.signIn;
    GoogleSignInAuthentication googleAut = await googleAcc.authentication;

    FirebaseUser firebaseUser = await firebaseAuth.signInWithGoogle(
      idToken: googleAut.idToken,
      acessToken: googleAut.accessToken,
    );

    //setelah login akna pindah dengan navigator
    return Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) =>
            new MyScreen(user: firebaseUser, googleSignIn: googleSignin)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Image.asset(
                "images/logo.png",
                width: 200,
                height: 200,
                alignment: Alignment.center,
              ),
            ),
            Center(
                child: Text(
              'Copyright by Widiyawati 2020',
              style: TextStyle(
                  color: Colors.black, height: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
            //new Padding(padding: const EdgeInsets.only(bottom: 20)),
            //supaya gambar yang disentuh bisa fungsi
            new InkWell(
              onTap: () {
                _signIn();
              },
              child: Image.asset(
                "images/logo.png",
                width: 200,
                height: 200,
                alignment: Alignment.center,
              ),
            ),
          ],
        ));
  }
}

class SignInWithGoogle {}
