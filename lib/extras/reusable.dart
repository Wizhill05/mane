import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:google_fonts/google_fonts.dart';

Color Light = toColor("f0f0f0");
Color Dark = toColor("012367");

toColor(String hexColor, {double opacity = 1}) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16)).withOpacity(opacity);
}

Image bannerWidget(String imageName, double x, double y) {
  return Image.asset(
    imageName,
    fit: BoxFit.contain,
    width: x,
    height: y,
    color: Light.withOpacity(0.8),
  );
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Light.withOpacity(0.9),
    cursorWidth: 2,
    cursorHeight: 20,
    style: TextStyle(color: Light.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Light,
      ),
      labelText: text,
      labelStyle: TextStyle(
          color: Light.withOpacity(0.6),
          fontWeight: FontWeight.bold,
          fontSize: 16),
      filled: true,
      fillColor: Light.withOpacity(0.05),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(width: 2, color: Light.withAlpha(200))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(width: 2, color: Light.withAlpha(255))),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Image ImageWidget(String imageName, double x, double y) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: x,
    height: y,
  );
}

AlertDialog alertMe(BuildContext context, String title, actions, contents) {
  return AlertDialog(
    actions: actions,
    contentPadding: EdgeInsets.all(20),
    content: contents,
    title: Text(title),
  );
}

getUsername() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser = auth.currentUser;
  final firestore = FirebaseFirestore.instance;
  final userDocRef = firestore.collection('users').doc(getUid());
  final userDocSnap = await userDocRef.get();

  if (userDocSnap.exists) {
    final userDocumentData = userDocSnap.data();
    final username = userDocumentData?['name'] ?? 'Unknown';
    debugPrint('Username: $username');
    return username;
  } else {
    debugPrint('User document not found');
    return null;
  }
}

getUid() {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser = auth.currentUser;
  String uid = currentUser?.uid ?? 'Login Error';
  return uid;
}

QrImageView genQR(String data) {
  return QrImageView(
    data: data,
    version: QrVersions.auto,
    size: 180.0,
    gapless: false,
    backgroundColor: Colors.white.withOpacity(0.1),
    eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.square, color: toColor("121212")),
    dataModuleStyle: QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.circle, color: toColor("121212")),
    errorStateBuilder: (context, error) {
      return Center(
        child: Text(
          'Error: $error',
          style: TextStyle(fontSize: 18),
        ),
      );
    },
  );
}

Container newcard(BuildContext context, String title, String desc,
    {bool isThumbsUp = false}) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    height: 200,
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Dark,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  child: Text(
                    "$title",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.josefinSans(
                      fontSize: 24,
                      color: toColor("d4d4d4"),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                width: MediaQuery.of(context).size.width * 0.9 - 30,
                child: Text(
                  "$desc",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    color: toColor("d4d4d4"),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ]))),
      ),
    ),
  );
}
