import 'package:analytics_flutter/home.dart';
import 'package:analytics_flutter/profile.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  int _currentIndex = 1;
  @override
  void initState() {
    super.initState();
    // Log the initial screen view when the Settings screen is first displayed
    _logScreenView('Settings');
  }

  // Function to log screen views
  Future<void> _logScreenView(String screenName) async {
    await _analytics.setCurrentScreen(screenName: screenName);
    // await _analytics.logEvent(
    //   name: 'screen_view',
    //   parameters: {'screen_name': screenName},
    // );
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
          children: [Text("Settings Page")],
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
            _logScreenView('Settings');
            // await _analytics.logEvent(name: 'navigate_to_settings');
          } else if (index == 2) {
            // await _analytics.logEvent(name: 'navigate_to_profile');

            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => profile()));
            _logScreenView('Profile');
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
