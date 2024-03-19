import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_userprofiledemo/homePage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_userprofiledemo/theme/api_constants.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.title});

  final String title;

  @override
  State<Profile> createState() => _ProfileState();
}

Future<String?> getTokenLocally(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future<void> removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("token");
}

class _ProfileState extends State<Profile> {
  // FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  int _currentIndex = 0;
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();

  bool editMode = false;
  bool isDataModified = false;

  Map<String, dynamic>? userProfile;

  // String email = "Fe@gmail.com";

  Future<void> getUserProfile() async {
    String? storedToken = await getTokenLocally("token");
    String? email = await getTokenLocally("email");

    final Uri url =
        Uri.parse('${api_constants.profile}$email');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $storedToken',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        print(userData);
        setState(() {
          userProfile = userData;
          firstNameController.text = userProfile?['firstName'] ?? '';
          lastNameController.text = userProfile?['lastName'] ?? '';
          contactNumberController.text =
              userProfile?['contactNumber']?.toString() ?? '';
        });
        // Successful response
        // print('Received data: ${response.body}');
      } else {
        // Handle error response
        print('Status code should be 200, but is ${response.statusCode}');
        print('Response: ${response.body}');
        // Handle errors accordingly
      }
    } catch (error) {
      print('Error: $error');
      // Handle network errors or other exceptions
    }
  }

  Future<void> updateUserProfile() async {
    String? storedToken = await getTokenLocally("token");
    String? email = await getTokenLocally("email");

    final Uri url =
        Uri.parse('${api_constants.profile}$email');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $storedToken',
    };
    try {
      final response = await http.put(
        url,
        headers: headers,
        body: json.encode({
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'contactNumber': int.tryParse(contactNumberController.text),
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> updatedUserProfile =
            json.decode(response.body);
        setState(() {
          userProfile = updatedUserProfile;
          editMode = false;
          isDataModified = false;
        });
        showSnackBar(context, 'Profile updated successfully!');
      } else if (response.statusCode == 403) {
        // Token expired, show token expired message
        showSnackBar(context, 'Token expired. Please log in again.');
      } else {
        // print('Failed to update user profile: ${response.reasonPhrase}');
        showSnackBar(
            context, 'Failed to update profile: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error updating user profile: $error');
      // Show a generic error message
      showSnackBar(context, 'An error occurred. Please try again.');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 123, 20),
        title: Text(
          'Profile',
          
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Align(
              //   alignment: Alignment.topCenter,
              //   child: Image.asset(
              //     api_constants.motivityLogo,
              //     height: 75,
              //     width: 200,
              //   ),
              // ),
              if (editMode)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'First Name',
                          ),
                      controller: firstNameController,
                      onChanged: (value) {
                        setState(() {
                          isDataModified = true;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Last Name',
                          ),
                      controller: lastNameController,
                      onChanged: (value) {
                        setState(() {
                          isDataModified = true;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Contact Number',
                          ),
                      controller: contactNumberController,
                      onChanged: (value) {
                        setState(() {
                          isDataModified = true;
                        });
                      },
                    ),

                    SizedBox(height: 20),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              updateUserProfile();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 226, 123,
                                  20), // Set the button color to orange
                            ),
                            child: Text(
                              'Save Profile',
                              ),
                          ),
                          SizedBox(width: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                editMode = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 226, 123,
                                  20), // Set the button color to orange
                            ),
                            child: Text(
                              'Cancel',
                              ),
                          ),
                        ],
                      ),
                    ),
                    ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    
                    Text(
                      'First Name:${userProfile?['firstName'] ?? ''}',
                      
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Last Name: ${userProfile?['lastName'] ?? ''}',
                     
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Contact Number: ${userProfile?['contactNumber'] ?? ''}',
                     
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // removeToken();
                            setState(() {
                              editMode = true;
                            });
                          },
                          child: Text(
                            'Edit Profile',
                            ),
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 226, 123, 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
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
                    builder: (context) => HomePage()));
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
            label: 'Profile',
          ),
          ],
        ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Profile(title: ''),
  ));
}
