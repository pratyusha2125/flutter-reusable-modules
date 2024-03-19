import 'package:analytics_flutter/profile.dart';
import 'package:analytics_flutter/settings.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  int _currentIndex = 0;
  // Log the initial screen view when the Home screen is first displayed

  @override
  void initState() {
    super.initState();
    // Log the initial screen view when the Home screen is first displayed
    _logScreenView('Home');
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
          children: [Text("Home Page")],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color.fromARGB(255, 226, 123, 20),
        currentIndex: _currentIndex, // Index 2 corresponds to SettingsPage
        onTap: (int index) async {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            _logScreenView('Home');
          } else if (index == 1) {
            // await _analytics.logEvent(name: 'navigate_to_settings');

            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Settings()));
            _logScreenView('Settings');
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
