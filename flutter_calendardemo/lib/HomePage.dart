import 'package:flutter/material.dart';
import 'package:flutter_calendardemo/event_calendar.dart';
import 'package:flutter_calendardemo/login.dart';
// import 'package:flutter_userprofiledemo/login.dart';
// import 'package:flutter_userprofiledemo/profile.dart';


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
         leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Login(title: '')));
          },
        ),
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EventCalenderScreen(),
              ),
            );
          // } else if (index == 2) {
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => PaymentScreen(),
          //     ),
          //   );
            // } else if (index == 3) {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => EventCalenderScreen(),
            //   ),
            // );
          }
        },
          
         items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'calendar',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.payment),
          //   label: 'payments',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.calendar_month),
          //   label: 'calendar',
          // ),
         ],
        ),
      );
  }
}