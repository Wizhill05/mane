import 'package:flutter/material.dart';
import 'package:mane/extras/reusable.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mane/screens/signin.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                fontSize: 24,
                color: toColor("ccccdd"),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          backgroundColor: Dark,

          toolbarHeight: 60, // Increase the height of the AppBar
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: toColor("d4d4d4"),
            ),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Column(children: <Widget>[
                      TextButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => SignIn()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Text("Logout"))
                    ])))));
  }
}
