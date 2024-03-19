import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bottomnavigationdemo/eventcalendar.dart';
import 'package:flutter_bottomnavigationdemo/homePage.dart';
import 'package:flutter_bottomnavigationdemo/payments.dart';
import 'package:flutter_bottomnavigationdemo/profile.dart';
import 'package:flutter_bottomnavigationdemo/settings.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _currentIndex = 0;
 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Google Maps',
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        backgroundColor: Color.fromARGB(255, 226, 123, 20),
      ),
      body: Center(
        child: Text(
          'Welcome to the Google Maps Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color.fromARGB(255, 226, 123, 20),
        currentIndex: 3, // Index 2 corresponds to SettingsPage
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage()
                        ));
          } else if (index == 1) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Profile(title: '')));
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ),
            );
          } else if (index == 3) {
            setState(() {
              _currentIndex = index;
            });
          } else if (index == 4) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentScreen(),
              ),
            );
             } else if (index == 5) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EventCalenderScreen(),
              ),
            );
            } else {
            }
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
        ],
      ),
    );
  }
}







