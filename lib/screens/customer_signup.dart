import 'package:flutter/material.dart';
import 'package:mane/extras/reusable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mane/main.dart';
import 'package:mane/screens/shop.dart';
import 'package:mane/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Future<void> makeUser(String name, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print(getUsername());
      await createDocumentWithId("users", getUid(),
          {"name": _nameTextController.text, "type": "user", "email": email});
      showDialog(
          context: context,
          builder: (context) => alertMe(
              context,
              "User Creation Success",
              [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Shop()),
                      );
                    },
                    child: Text("Ok"))
              ],
              const Text("User Created")));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => alertMe(
              context,
              "User Creation Error",
              [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Ok"))
              ],
              Text("$e")));
    }
  }

  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.cover,
                    opacity: 0.25),
                gradient: LinearGradient(
                  colors: [Dark, toColor("001030")],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                        child: SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 3.95,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Register",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.josefinSans(
                                  fontSize: 30,
                                  color: Light,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
                        child: reusableTextField(
                            "Name", Icons.person, false, _nameTextController),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                        child: reusableTextField(
                            "Email", Icons.email, false, _emailTextController),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 126,
                              child: reusableTextField("Password", Icons.key,
                                  true, _passwordTextController),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                                width: 56,
                                height: 60,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      side: WidgetStateProperty.all(BorderSide(
                                          width: 2,
                                          color: Light.withAlpha(200))),
                                      shadowColor:
                                          WidgetStateProperty.resolveWith(
                                              (states) {
                                        return Light.withOpacity(0.05);
                                      }),
                                      backgroundColor:
                                          // ignore: deprecated_member_use
                                          WidgetStateProperty.resolveWith(
                                              (states) {
                                        return Light.withOpacity(0.05);
                                      }),
                                      shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      )),
                                    ),
                                    onPressed: () {
                                      makeUser(
                                          _nameTextController.text,
                                          _emailTextController.text,
                                          _passwordTextController.text);
                                    },
                                    child: Icon(
                                      Icons.app_registration_rounded,
                                      color: Light,
                                      size: 23,
                                    ))),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => SignIn()),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: const Text(
                                "Return To Sign In",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ])))));
  }
}
