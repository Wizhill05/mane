import 'package:flutter/material.dart';
import 'package:mane/extras/reusable.dart';
import 'package:mane/screens/Bookings.dart';
import 'package:mane/screens/User.dart';
import 'package:mane/screens/shop.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class navigation extends StatefulWidget {
  const navigation({super.key});

  @override
  State<navigation> createState() {
    return _navigationState();
  }
}

class _navigationState extends State<navigation> {
  int _selectedIndex = 0;
  static List<Widget> _pages = [Shop(), Bookings(), User()];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double pad = MediaQuery.of(context).size.width / 2 - 160;
    if (pad <= 20) {
      pad = 20;
    }
    return Scaffold(
        backgroundColor: toColor("d4d4d4"),
        body: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.fromLTRB(pad, 0, pad, 0),
          decoration: BoxDecoration(
            color: Dark,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: GNav(
              gap: 3,
              tabs: const [
                GButton(
                  icon: Icons.hail,
                  text: 'Saloons',
                ),
                GButton(
                  icon: Icons.library_books,
                  text: 'Bookings',
                  iconSize: 18,
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'User',
                  iconSize: 20,
                ),
              ],
              color: toColor("d4d4d4").withOpacity(0.5),
              activeColor: toColor("d4d4d4"),
              padding: EdgeInsets.all(16),
              haptic: true,
              onTabChange: _onItemTapped,
            ),
          ),
        ));
  }
}
