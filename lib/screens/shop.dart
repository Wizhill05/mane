import 'package:flutter/material.dart';
import 'package:mane/extras/reusable.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mane/main.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  Map<String, dynamic>? saloons = {
    "Saloons 1": {
      "name": "null",
      "tagline": "null",
      "service": {"null": 0},
      "address": "null",
      "rating": 0.0,
      "reviews": 0,
    },
  };

  void initState() {
    super.initState();
    getSaloonData().then((data) {
      setState(() {
        saloons = data;
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
              "Saloons",
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
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: toColor("d4d4d4"),
            ),
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Column(
                      children: [
                            Container(
                                child: SizedBox(
                              height: 10,
                            ))
                          ] +
                          saloons!.keys.map((key) {
                            return newcard(
                              context,
                              key,
                              saloons![key]["name"],
                              saloons![key]["tagline"],
                              saloons![key]["service"],
                              saloons![key]["address"],
                              saloons![key]["rating"],
                              saloons![key]["reviews"],
                            );
                          }).toList() +
                          [
                            Container(
                                child: SizedBox(
                              height: 30,
                            ))
                          ],
                    )))));
  }
}
