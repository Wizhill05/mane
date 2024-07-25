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
  List<Map> categories = [
    {"service": "Swimming", "price": 300, "isChecked": false},
    {"service": "Cycling", "price": 300, "isChecked": false},
    {"service": "Tennis", "price": 300, "isChecked": false},
    {"service": "Boxing", "price": 300, "isChecked": false},
    {"service": "Volleyball ", "price": 300, "isChecked": false},
    {"service": "Bowling ", "price": 300, "isChecked": false},
  ];

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: InkWell(
          onTap: () {
            SelectedItems(categories);
          },
          splashColor: Dark.withAlpha(200),
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width - 160,
            decoration: BoxDecoration(
              color: Dark,
              borderRadius: const BorderRadius.all(
                  Radius.circular(40)), // Make it pill-shaped
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.shopping_cart, color: Colors.white),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Book Appointment",
                  style: GoogleFonts.josefinSans(
                    fontSize: 16,
                    color: toColor("#e3e8f0"),
                    fontWeight: FontWeight.w800,
                  ),
                )
              ]),
            ),
          ),
        ),
        body: Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: toColor("d4d4d4"),
            ),
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 80,
                        child: Text(
                          "Choose The Services You Want:",
                          style: GoogleFonts.dmSans(
                              fontSize: 20,
                              color: Dark,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        color: Colors.black26,
                        height: 10,
                        thickness: 2,
                      ),
                      const SizedBox(height: 10),
                      Column(
                          children: categories.map((favorite) {
                        return CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: Dark,
                            checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            value: favorite["isChecked"],
                            title: Text(
                              favorite["service"],
                              style: GoogleFonts.dmSans(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text("₹${favorite["price"]}",
                                style: GoogleFonts.dmSans(
                                  fontSize: 18,
                                  color: Dark,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                )),
                            onChanged: (val) {
                              setState(() {
                                favorite["isChecked"] = val;
                              });
                            });
                      }).toList()),
                    ])))));
  }
}

Future<Map<String, dynamic>> getOneSaloonData(String documentId) async {
  final firestore = FirebaseFirestore.instance;

  final docRef = firestore.collection('shops').doc(documentId);

  final docSnapshot = await docRef.get();

  return docSnapshot.data() as Map<String, dynamic>;
}

Map<String, int> SelectedItems(List categories) {
  Map<String, int> selectedItems = {};

  for (var category in categories) {
    if (category["isChecked"]) {
      selectedItems[category["service"]] = category["price"];
    }
  }

  debugPrint("Selected items: $selectedItems");
  return selectedItems;
}
