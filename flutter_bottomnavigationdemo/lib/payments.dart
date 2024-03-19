import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bottomnavigationdemo/eventcalendar.dart';
import 'package:flutter_bottomnavigationdemo/homePage.dart';
import 'package:flutter_bottomnavigationdemo/maps.dart';
import 'package:flutter_bottomnavigationdemo/profile.dart';
import 'package:flutter_bottomnavigationdemo/settings.dart';


class PaymentScreen extends StatefulWidget {

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  
  final formkey = GlobalKey<FormState>();
  int _currentIndex = 0;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // or Colors.black if isDarkMode is true
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 123, 20), // or Colors.white if isDarkMode is true
        title: Text('Payment'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomePage()));
          },
      ),
      ),
      body: Center(
        child: Text(
          'Welcome to the Payment Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
            
        bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color.fromARGB(255, 226, 123, 20),
        currentIndex: 4, // Index 2 corresponds to SettingsPage
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage()
                        ));
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Profile(title: ''),
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MapScreen(),
              ),
            );
          } else if (index == 4) {
            setState(() {
              _currentIndex = index;
            });
            } else if (index == 5) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EventCalenderScreen(),
              ),
            );
            }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
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



































