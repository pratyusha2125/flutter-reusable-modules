import 'package:flutter/material.dart';
import 'package:flutter_bottomnavigationdemo/eventcalendar.dart';
import 'package:flutter_bottomnavigationdemo/maps.dart';
import 'package:flutter_bottomnavigationdemo/payments.dart';
import 'package:flutter_bottomnavigationdemo/profile.dart';
import 'package:flutter_bottomnavigationdemo/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: const Color.fromARGB(255, 226, 123, 20),
        centerTitle: true,
       
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
        bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color.fromARGB(255, 226, 123, 20),
        currentIndex: 0, // Index 2 corresponds to SettingsPage
        onTap: (int index) {
          if (index == 0) {
            setState(() {
              _currentIndex = index;
            });
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MapScreen(),
              ),
            );
          } else if (index == 4) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentScreen(),
              ),
            );
            }else if (index == 5) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EventCalenderScreen(),
              ),
            );
           } else {
            setState(() {
              _currentIndex = index;
            });
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
            icon: Icon(Icons.calendar_view_month_rounded),
            label: 'Calender',
          ),
           ],
      ),
      );
  }
}