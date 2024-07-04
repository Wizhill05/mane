import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mane/extras/reusable.dart';
import 'package:mane/screens/navig.dart';
import 'package:mane/screens/shop.dart';
import 'package:mane/screens/signin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mane/screens/customer_signup.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    debugPrint("Connection Error");
    SnackBar(
      content: Text("Connection Error, Try Again"),
    );
    return;
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          primarySwatch: Colors.lightBlue,
          fontFamily: GoogleFonts.josefinSans().fontFamily,
        ),
        home: AuthenticationWrapper());
  }
}

class AuthenticationWrapper extends StatefulWidget {
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserAuthentication();
    });
  }

  void checkUserAuthentication() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => navigation()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}

class userData {
  String name, email, type;
  userData({
    required this.name,
    required this.email,
    required this.type,
  });
}

Future<void> createDocumentWithId(String collectionName, String documentId,
    Map<String, dynamic> documentData) async {
  FirebaseFirestore.instance
      .collection(collectionName)
      .doc(documentId)
      .set(documentData)
      .then((value) => print("Document added"))
      .catchError((error) => print("Failed to add document: $error"));
}

Future<void> updateDataInFirestore(String collectionName, String documentId,
    String fieldName, var newValue) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    await _firestore.collection(collectionName).doc(documentId).update({
      fieldName: newValue,
    });
    debugPrint('Data updated successfully!');
  } catch (e) {
    debugPrint('Error updating data: $e');
  }
}
