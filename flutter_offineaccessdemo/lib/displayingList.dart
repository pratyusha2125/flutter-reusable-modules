import 'package:flutter/material.dart';
import 'package:flutter_offineaccessdemo/databaseManager.dart';


class DisplayingList extends StatefulWidget {
  const DisplayingList({super.key});

  @override
  State<DisplayingList> createState() => _DisplayingListState();
}

class _DisplayingListState extends State<DisplayingList> {
  List<Map<String, dynamic>> employees = [];
  List<Map<String, dynamic>> filteredEmployees = [];
  bool dataFetched = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 123, 20),
        title: Text('Search'),
        centerTitle: true,
      ),
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
    );
  }
}
