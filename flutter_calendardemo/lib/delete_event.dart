// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_calendardemo/event_calendar.dart';
import 'package:flutter_calendardemo/theme/api_constants.dart';
// import 'package:flutter_userprofile/event_calendar.dart';
// import 'package:fluttersociallogin/bottomNavScreens/SettingsPage.dart';
// import 'package:fluttersociallogin/bottomNavScreens/event_calendar.dart';
// import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DeleteEvent extends StatefulWidget {
 

  @override
  _DeleteEventState createState() => _DeleteEventState();
}

class _DeleteEventState extends State<DeleteEvent> {

    Future<String?> getTokenLocally(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future<void> removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("token");
}


  String id = '';
  String eventDetails = '';

  Future<void> deleteEvent() async {
    String? storedToken = await getTokenLocally("token");
    final apiUrl = '${api_constants.eventcalendar}$id'; // Replace with your API URL

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $storedToken',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          eventDetails = 'Event deleted successfully!';
        });
      } else {
        print('Failed to delete event');
      }
    } catch (error) {
      print('Error deleting event: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 123, 20),
        title: Text('Delete Event',),
         centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => EventCalenderScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter ID',
              ),
              onChanged: (value) {
                setState(() {
                  id = value;
                });
              },
            ),
            SizedBox(height: 20),
            // style: ElevatedButton.styleFrom(
            //             primary: const Color.fromARGB(255, 226, 123,20), // Set the button color to orange
            // ),
            ElevatedButton(
              onPressed: deleteEvent,
               style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 226, 123, 20)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ))),
              child: Text('Delete Event',),
            ),
            SizedBox(height: 20),
            if (eventDetails.isNotEmpty)
              Text(
                eventDetails,
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}