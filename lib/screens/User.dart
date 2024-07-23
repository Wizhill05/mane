import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mane/extras/reusable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mane/main.dart';
import 'package:mane/screens/signin.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

Future<userData> getUserData() async {
  String uid = getUID();
  final db = FirebaseFirestore.instance;
  final collection = db.collection('users');
  final document = collection.doc(uid);
  final data = await document.get();
  final _userData = data.data();

  String name = 'default';
  String email = 'default';
  String type = 'default';
  if (_userData == null) {
    print("null Data");
  } else {
    name = await (_userData['name'] as FutureOr<String>?) ?? 'default';
    email = await (_userData['email'] as FutureOr<String>?) ?? 'default';
    type = await (_userData['type'] as FutureOr<String>?) ?? 'default';
  }
  debugPrint("$name,$email,$type");
  return userData(name: name, email: email, type: type);
}

class _UserState extends State<User> {
  userData? _userData;
  void initState() {
    super.initState();
    getUserData().then((data) {
      setState(() {
        _userData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),

          title: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Text(
              "User Settings",
              style: GoogleFonts.josefinSans(
                fontSize: 32,
                color: toColor("#e3e8f0"),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          backgroundColor: Dark,

          toolbarHeight: 70, // Increase the height of the AppBar
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: toColor("d4d4d4"),
            ),
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Container(
                  child: Text(
                    "Hello ${_userData?.name}!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                      fontSize: 40,
                      color: toColor("121212"),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Container(
                  child: Text(
                    "You are signed in with \n${_userData?.email}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                      fontSize: 20,
                      color: toColor("121212"),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: genQR(getUID()),
              ),
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const SignIn()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      "If you want to Log Out, Click here!",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: Dark,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              )
            ])));
  }
}
