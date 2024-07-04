import 'package:flutter/material.dart';
import 'package:mane/extras/reusable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mane/main.dart';
import 'package:mane/screens/customer_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mane/screens/shop.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                          height: MediaQuery.of(context).size.height / 2.8,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Login to Mane",
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
                                      try {
                                        FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                                email:
                                                    _emailTextController.text,
                                                password:
                                                    _passwordTextController
                                                        .text);
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Shop()),
                                          (Route<dynamic> route) => false,
                                        );
                                      } catch (e) {
                                        showDialog(
                                            context: context,
                                            builder: (context) => alertMe(
                                                context,
                                                "User Signin Error",
                                                [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("Ok"))
                                                ],
                                                Text("$e")));
                                      }
                                    },
                                    child: Icon(
                                      Icons.login_sharp,
                                      color: Light,
                                      size: 23,
                                    ))),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 15),
                        child: InkWell(
                          onTap: () {
                            // Navigate to the Forgot Password page
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: const Text(
                                "Forgot Password?",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: const Text(
                                "No account?",
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
