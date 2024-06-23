import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

getUsername() {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser = auth.currentUser;
  String username = currentUser?.email ?? 'Login Error';
  username = username.substring(0, 10);
  return username;
}

getUid() {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser = auth.currentUser;
  String uid = currentUser?.uid ?? 'Login Error';
  return uid;
}
