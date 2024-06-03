import 'package:flutter/material.dart';

Color Light = toColor("f0f0f0");
Color Dark = toColor("012367");

toColor(String hexColor, {double opacity = 1}) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
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

Container uiButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: 500,
    height: 50,
    margin: const EdgeInsets.fromLTRB(30, 10, 30, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Color.fromARGB(255, 214, 214, 214);
            }
            return Color.fromARGB(255, 212, 212, 212);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
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
