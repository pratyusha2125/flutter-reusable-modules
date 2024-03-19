import 'package:flutter/material.dart';
import 'package:flutter_calendardemo/HomePage.dart';
import 'package:flutter_calendardemo/add_event.dart';
import 'package:flutter_calendardemo/delete_event.dart';
// import 'package:flutter_userprofile/add_event.dart';
// import 'package:flutter_userprofile/delete_event.dart';
// import 'package:flutter_userprofile/homePage.dart';
// import 'package:flutter_userprofile/payment.dart';
// import 'package:flutter_userprofile/useredit_profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_calendardemo/theme/api_constants.dart';

void main() {
  runApp(MaterialApp(
    home: EventCalenderScreen(),
  ));
}

class EventCalenderScreen extends StatefulWidget {
  @override
  _EventCalenderScreenState createState() => _EventCalenderScreenState();
  
}

class _EventCalenderScreenState extends State<EventCalenderScreen> {
      int _currentIndex = 0;

  Future<String?> getTokenLocally(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future<void> removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("token");
}

  DateTime? selectedDate;
  List<dynamic>? eventDetails;

  @override
  void initState() {
    super.initState();
    
  }

    Future<void> getEvents() async {
    String? storedToken = await getTokenLocally("token");

    String? email = await getTokenLocally("email");
    
    if (email == null || selectedDate == null) {
      
      return;
    }

    String encodedEmail = Uri.encodeComponent(email!);
    String createdBy = encodedEmail;
    String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
    // final apiUrl = 'http://172.20.100.13:7071/api/user/event/$encodedEmail?date=$formattedDate';
    final apiUrl = '${api_constants.eventcalendar}$createdBy?date=$formattedDate';
     
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $storedToken',
        
      });
      print(formattedDate);

      if (response.statusCode == 200) {
        // final Map<String, dynamic> eventDetails = json.decode(response.body);
        // print(eventDetails);
        setState(() {
          eventDetails = json.decode(response.body);
        });
      } else {
        print(response.statusCode);
        throw Exception('Failed to load event details');
      }
    } catch (error) {
      print('Error fetching event details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
         centerTitle: true,
         backgroundColor: const Color.fromARGB(255, 226, 123, 20),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2024, 1, 1),
            lastDay: DateTime(2024, 12, 31),
            focusedDay: DateTime.now(),
             selectedDayPredicate: (day) {
              return isSameDay(selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                selectedDate = selectedDay;
              });
              getEvents();
          
              },
          ),
          SizedBox(height: 20),
          Text(
            'Selected Date: ${selectedDate != null ? DateFormat('dd/MM/yyyy').format(selectedDate!) : ''}',
            style: TextStyle(fontSize: 18),
          ),
           ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateEventScreen(selectedDate: selectedDate)),
              );
            },
            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 226, 123,20), // Set the button color to orange
                              shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                ),
                 ),
            child: Icon(Icons.add),
          ),
           SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    getEvents();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 226, 123, 20), // Set the button color to orange
                  ),
                  child: Text(
                    'GetEvents',
                    // style: TextStyle(fontSize: GetConfig().currentFontSize),
                  ),
                ),
                SizedBox(width: 10), // Add spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeleteEvent(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 226, 123, 20), // Set the button color to orange
                  ),
                  child: Text(
                    'Delete',
                    // style: TextStyle(fontSize: GetConfig().currentFontSize),
                  ),
                ),
              ],
            ),

          //  ElevatedButton(
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => DeleteEvent(),
          //           ),
          //         );
          //       },
          //        style: ElevatedButton.styleFrom(
          //                     primary: const Color.fromARGB(255, 226, 123,20), // Set the button color to orange
          //        ),
          //       child: Text('Delete'),
          //     ),
          //    ElevatedButton(
          //    onPressed: () {
          //      getEvents();
          //   },
          //    style: ElevatedButton.styleFrom(
          //    primary: const Color.fromARGB(255, 226, 123,20), // Set the button color to orange
          //   ),
          //   child: Text('GetEvents'.tr,style: TextStyle(fontSize: GetConfig().currentFontSize),),
          // ),
          //  ElevatedButton(
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => DeleteEvent(),
          //           ),
          //         );
          //       },
          //        style: ElevatedButton.styleFrom(
          //                     primary: const Color.fromARGB(255, 226, 123,20), // Set the button color to orange
          //        ),
          //       child: Text('Delete'.tr,style: TextStyle(fontSize: GetConfig().currentFontSize),),
          //     ),
          Flexible(
            child: ListView.builder(
              itemCount: eventDetails?.length ?? 0,
              itemBuilder: (context, index) {
                final item = eventDetails![index];
                return ListTile(
                  title: Text('ID: ${item['id']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Event Name: ${item['name']}'),
                      Text('Created By: ${item['createdBy']}'),
                      Text('Event Location: ${item['location']}'),
                      Text('Event Date: ${item['date']}'),
                      Text('Event Time: ${item['time']}'),
                      Text('Status: ${item['status'] ?? 'active'}'),
                      ],
                  ),
                );
              },
            ),
          ),
        ],
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
      // ),
    );
  }
  // Future<void> _sendAnalyticsEvent(String eventName) async {
  //   await _analytics.logEvent(name: eventName);
  // }
}

