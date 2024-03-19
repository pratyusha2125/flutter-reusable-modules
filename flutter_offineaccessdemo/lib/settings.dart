import 'dart:convert';

// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offineaccessdemo/Employee.dart';
import 'package:flutter_offineaccessdemo/databaseManager.dart';
import 'package:flutter_offineaccessdemo/homePage.dart';
import 'package:flutter_offineaccessdemo/login.dart';

import 'package:http/http.dart' as http;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  int _currentIndex = 0;
  double fontSize = 15.0;
  TextEditingController fontSizeController = TextEditingController();
  // TextEditingController syncController =TextEditingController();
  // Locale? selectedLocale = Get.locale;
  bool isDarkMode = false;
  // bool isSyncing = false;





  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Success',
            // style: TextStyle(fontSize: GetConfig().currentFontSize),
          ),
          content: Text(
            'Data inserted successfully',
            // style: TextStyle(fontSize: GetConfig().currentFontSize),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                // style: TextStyle(fontSize: GetConfig().currentFontSize),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> getAllEmployees(BuildContext context) async {
    var baseUrl =
        "http://172.18.3.72:7071/api/user/getAllEmployees"; // Update the URL with appropriate endpoint

    try {
      var url = Uri.parse(baseUrl);
      var response =
          await http.get(url, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        // Parse the response JSON to get employee details
        // var responseData = json.decode(response.body);

        print(response.body);

        final List<dynamic> jsonResponse = json.decode(response.body);

        // Assuming you have a DatabaseManager instance
        final DatabaseManager databaseManager = DatabaseManager.instance;
        // Create a table in the database (if not exists)
        List<Map<String, dynamic>> existingEmployees =
            await databaseManager.fetchEmployees();
        if (existingEmployees.isNotEmpty) {
          databaseManager.deleteData();
        }
        // Loop through the employees in the JSON response and insert each into the database
        for (dynamic employeeJson in jsonResponse) {
          final Employee employee = Employee.fromJson(employeeJson);

          databaseManager.insertEmployeeData(employee);
        }

        print('data inserted sucessfully');

        showSuccessDialog(context);
      } else {
        // Handle unsuccessful response
        return null;
      }
    } catch (error) {
      // Handle network or other errors
      print("Error: $error");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 226, 123, 20),
        title: Text(
          'Settings',
         
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage(email: '')),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Sync:',
                      // style: TextStyle(fontSize: GetConfig().currentFontSize),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 120,
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        getAllEmployees(context);
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 226, 123, 20)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ))),
                      child: Text('Sync',
                          // style:
                          //     TextStyle(fontSize: GetConfig().currentFontSize)
                              ),
                    ),
                  ),
                ],
              ),
               ]
                ),
               ),
              ),
               bottomNavigationBar: BottomNavigationBar(
               selectedItemColor: Colors.black,
               unselectedItemColor: const Color.fromARGB(255, 226, 123, 20),
               currentIndex: 1, // Index 2 corresponds to SettingsPage
               onTap: (int index) {
               if (index == 0) {
                Navigator.pushReplacement(
                  context,
                MaterialPageRoute(
                    builder: (context) => HomePage(email: '')));
          } else if (index == 1) {
            setState(() {
              _currentIndex = index;
            });
         
          }
        },
         items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Settings',
          ),
          ],
        ),
      );
  }
 }


