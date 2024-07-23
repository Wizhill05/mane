// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:mane/extras/reusable.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mane/main.dart';
import 'package:mane/screens/shop.dart';

// ignore: camel_case_types
class makeAppointment extends StatefulWidget {
  final String id;

  const makeAppointment(this.id, {super.key});

  @override
  State<makeAppointment> createState() => _makeAppointmentState(id);
}

class _makeAppointmentState extends State<makeAppointment> {
  final String id;

  _makeAppointmentState(this.id);

  Map<String, dynamic>? saloon = {
    "name": "null",
    "tagline": "null",
    "service": {"null": 0},
    "address": "null",
    "rating": 0.0,
    "reviews": 0,
  };

  void initState() {
    super.initState();

    getOneSaloonData(id).then((data) {
      setState(() {
        saloon = data;
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
              "${saloon?["name"]}",
              style: GoogleFonts.josefinSans(
                fontSize: 24,
                color: toColor("#e3e8f0"),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          backgroundColor: Dark,

          toolbarHeight: 70, // Increase the height of the AppBar
        ),
        body: Container());
  }
}

Future<Map<String, dynamic>> getOneSaloonData(String documentId) async {
  final firestore = FirebaseFirestore.instance;

  final docRef = firestore.collection('shops').doc(documentId);

  final docSnapshot = await docRef.get();

  return docSnapshot.data() as Map<String, dynamic>;
}
