import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_settingsdemo/SettingsPage.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  final String email;

  const HomePage({Key? key, required this.email, String? token})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 123, 20),
        title: Text(
          'Home'.tr,
          style: TextStyle(fontSize: GetConfig().currentFontSize),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SettingsPage()));
          },
        ),
      ),
      body: Column(
        children: [],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color.fromARGB(255, 226, 123, 20),
        // Index 2 corresponds to SettingsPage
        currentIndex: 0, // Index 2 corresponds to SettingsPage
        onTap: (int index) {
          if (index == 0) {
            setState(() {
              _currentIndex = index;
            });
          } else if (index == 1) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SettingsPage()));
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings'.tr,
          ),
        ],
        selectedLabelStyle: TextStyle(fontSize: GetConfig().currentFontSize),
        unselectedLabelStyle: TextStyle(fontSize: GetConfig().currentFontSize),
      ),
    );
  }
}
