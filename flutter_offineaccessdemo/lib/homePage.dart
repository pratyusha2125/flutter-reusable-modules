import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_offineaccessdemo/Employee.dart';
import 'package:flutter_offineaccessdemo/databaseManager.dart';
import 'package:flutter_offineaccessdemo/login.dart';
import 'package:flutter_offineaccessdemo/settings.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final String email;

  const HomePage({Key? key, required this.email, String? token})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Map<String, dynamic>> employees = [];
  List<Map<String, dynamic>> filteredEmployees = [];
  bool dataFetched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 123, 20),
        title: Text(
          'Home',
        ),
        centerTitle: true,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pushReplacement(context,
        //         MaterialPageRoute(builder: (context) => Login(title: '')));
        //   },
        // ),
      ),
      //body content
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterEmployees(value);
              },
              decoration: InputDecoration(
                hintText: 'Search by Department or Organization',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 226, 123, 20))),
              ),
            ),
          ),
          if (dataFetched)
            Expanded(
              child: ListView.builder(
                itemCount: filteredEmployees.length,
                itemBuilder: (context, index) {
                  var employee = filteredEmployees[index];
                  return ListTile(
                    title: Text('Id:${employee['_id']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Designation: ${employee['designation']}'),
                        Text('Department: ${employee['department']}'),
                        Text('Organization: ${employee['organization']}'),
                        Text('PhoneNumber: ${employee['phoneNumber']}'),
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
                builder: (context) => SettingsPage(),
              ),
            );
          }
        },

        items: [
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

  Future<void> getEmployeesFromDB() async {
    final DatabaseManager databaseManager = DatabaseManager.instance;
    List<Map<String, dynamic>> fetchedEmployees =
        await databaseManager.fetchEmployees();

    setState(() {
      employees = fetchedEmployees;
      filteredEmployees =
          fetchedEmployees; // Initially set both lists to the full employee list
      dataFetched = true;
    });
  }

  void filterEmployees(String searchText) async {
    if (!dataFetched) {
      await getEmployeesFromDB();
    }
    setState(() {
      filteredEmployees = employees.where((employee) {
        return employee['department']
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            employee['organization']
                .toLowerCase()
                .contains(searchText.toLowerCase());
      }).toList();
    });
  }

  static Future<void> getAllEmployees() async {
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
}
