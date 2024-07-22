import 'package:flutter/material.dart';
import 'package:mane/extras/reusable.dart';
import 'package:google_fonts/google_fonts.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
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
              "Saloons",
              style: GoogleFonts.josefinSans(
                fontSize: 36,
                color: toColor("ccccdd"),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          backgroundColor: Dark,

          toolbarHeight: 80, // Increase the height of the AppBar
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: toColor("d4d4d4"),
            ),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Column(children: <Widget>[
                      newcard(
                          context,
                          "Nayeem Hair Cut Saloon",
                          "Where Style Meets Perfection",
                          {
                            "Trims": 299,
                            "Haircut": 899,
                          },
                          "Scindia House, 7, Connaught Cir, Connaught Place, New Delhi, Delhi 110001",
                          4.4,
                          42),
                    ])))));
  }
}
