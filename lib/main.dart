import 'package:flutter/material.dart';
import 'package:mane/extras/reusable.dart';
import 'package:mane/screens/shop.dart';
import 'package:mane/screens/signin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mane/screens/customer_signup.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mane',
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.brown,
          fontFamily: GoogleFonts.josefinSans().fontFamily,
        ),
        home: SignIn());
  }
}
