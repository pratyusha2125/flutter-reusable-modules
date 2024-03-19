final String employeetable = 'employee';

class EmployeeFields {
  static final String id = '_id';
  static final String designation = 'designation';
  static final String department = 'department';
  static final String organization = 'organization';
  static final String phoneNumber = 'phoneNumber';
}

class Employee {
  // DatabaseManager database = DatabaseManager.instance;
  final int? id;
  final String designation;
  final String department;
  final String organization;
  final String phoneNumber;

  Employee(
      {required this.id,
      required this.designation,
      required this.department,
      required this.organization,
      required this.phoneNumber});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        id: json['id'],
        designation: json['designation'],
        department: json['department'],
        organization: json['organization'],
        phoneNumber: json['phoneNumber']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'designation': designation,
      'department': department,
      'organization': organization,
      'phoneNumber': phoneNumber
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
        id: map['id'],
        designation: map['designation'],
        department: map['department'],
        organization: map['organization'],
        phoneNumber: map['phoneNumber']
        // Assign other properties from the map...
        );
  }
  Map<String, dynamic> toJson() => {
        EmployeeFields.id: id,
        EmployeeFields.designation: designation,
        EmployeeFields.department: department,
        EmployeeFields.organization: organization,
        EmployeeFields.phoneNumber: phoneNumber
      };

  // Implement toString to make it easier to see information about  // each dog when using the print statement.  @override
  String toString() {
    return 'Employee{ designation: $designation, department: $department, organization: $organization, phoneNumber:$phoneNumber }';
  }
}
