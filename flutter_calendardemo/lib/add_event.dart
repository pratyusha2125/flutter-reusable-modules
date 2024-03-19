import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_calendardemo/theme/api_constants.dart';

void main() {
  runApp(MaterialApp(
    home: CreateEventScreen(),
  ));
}

class CreateEventScreen extends StatefulWidget {
  final DateTime? selectedDate;
  CreateEventScreen({Key? key, this.selectedDate}) : super(key: key);

  @override
  _CreateEventScreenState createState() =>
      _CreateEventScreenState(selectedDate: selectedDate);
}

Future<String?> getTokenLocally(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future<void> removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("token");
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final formKey = GlobalKey<FormState>();

  String namePattern = r'^[a-zA-Z]+$';
  String timePattern = r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$';
  bool _autoValidate = true;

  String name = '';
  String createdBy = '';
  String location = '';
  String time = '';
  late DateTime date;

  _CreateEventScreenState({DateTime? selectedDate}) {
    date = selectedDate ?? DateTime.now();
  }

// Your API endpoint URL

  final apiUrl = api_constants.eventcalendar; // Your API endpoint URL

  Future<void> createEvent() async {
    String? storedToken = await getTokenLocally("token");
    String? email = await getTokenLocally("email");

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $storedToken',
        },
        body: jsonEncode({
          'name': name,
          'createdBy': email,
          'location': location,
          'date': DateFormat('dd/MM/yyyy').format(date),
          'time': time,
        }),
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Success',
                style: TextStyle(fontSize: 16),
              ),
              content: Text(
                'Event created successfully',
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            );
          },
        );
        setState(() {
          name = '';
          location = '';
          time = '';
        });
      } else {
        throw Exception('Failed to create event');
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Error',
              style: TextStyle(fontSize: 16),
            ),
            content: Text('Failed to create event'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        time = '${picked.hour}:${picked.minute}';
      });
      String? validationResult = validateTime(time);
      if (validationResult != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(validationResult),
          ),
        );
        setState(() {
          time = '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 123, 20),
        title: Text('Create Event'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                      'Select Date: ${DateFormat('dd/MM/yyyy').format(date)}'),
                ),
                SizedBox(height: 20),
                Text(
                  'Event Name:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Enter Event Name'),
                  validator: (value) => validateName(value!),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Location:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Enter Location'),
                  validator: (value) => validateLocation(value!),
                  onChanged: (value) {
                    setState(() {
                      location = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Time:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(hintText: 'Select Time'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          time,
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      createEvent();
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 226, 123, 20)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ))),
                  child: Text('Create Event'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validateName(String value) {
    RegExp regExp = RegExp(namePattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid event name';
    }
  }

  String? validateLocation(String value) {
    if (value.isEmpty) {
      return 'Location cannot be empty';
    }
  }

  String? validateTime(String value) {
    RegExp regExp = RegExp(timePattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid time (HH:MM)';
    }
  }
}
