import 'package:analytics_flutter/home.dart';
import 'package:analytics_flutter/settings.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    // Log the initial screen view when the Profile screen is first displayed
    _logScreenView('Profile');
  }

  Future<void> _logScreenView(String screenName) async {
    await _analytics.setCurrentScreen(screenName: screenName);
    // await _analytics.logEvent(
    //   name: 'screen_view',
    //   parameters: {'screen_name': screenName},
    // );

    // // Log a custom event specific to the Profile screen
    // if (screenName == 'Profile') {
    //   await _analytics.logEvent(name: 'view_profile_screen');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 226, 123, 20),
        title: Text("Analytics"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("profile Page")],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color.fromARGB(255, 226, 123, 20),
        currentIndex: _currentIndex,
        onTap: (int index) async {
          setState(() {
            _currentIndex = index;
          });

          // Log the screen view based on the selected index
          if (index == 0) {
            // await _analytics.logEvent(name: 'navigate_to_home');

            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
            _logScreenView('Home');
          } else if (index == 1) {
            // await _analytics.logEvent(name: 'navigate_to_settings');

            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Settings()));
            _logScreenView('Settings');
          } else if (index == 2) {
            _logScreenView('Profile');
            // await _analytics.logEvent(name: 'navigate_to_profile');
          }
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
