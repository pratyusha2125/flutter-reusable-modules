## Your Flutter OfflineAccess App

## Description
 
This Flutter project demonstrates offline data access using SQLite database. It includes functionality to fetch employee data from a remote server, store it locally in a SQLite database, and display it in a list with search functionality.
 
## Features
 
1. databaseManager.dart
   Contains the DatabaseManager class responsible for managing the SQLite database.
   Provides methods to initialize the database, insert employee data, delete data, fetch employees, and create database tables.
   Utilizes the Employee model for data manipulation.
 
2. Employee.dart
   Defines the Employee model class representing an employee with attributes like id, designation, department, organization, and    phoneNumber.
 
3. homePage.dart
   Implements the HomePage widget, which serves as the main screen of the application.
   Allows users to search for employees by department or organization.
   Includes functionality to fetch employees from the remote server and sync them with the local database.
   Displays a list of employees fetched from the local database.
 
4. displayingList.dart
   Defines the DisplayingList widget, which displays a list of employees fetched from the local database.
   Provides search functionality to filter employees based on department or organization.
5. settings.dart
   Implements the SettingsPage widget, which allows users to configure app settings.
   Provides an option to sync employee data from the remote server to the local database.
   Includes navigation options to go back to the home page or access settings.

 
## Getting Started
 
Follow these steps to get your project up and running:
 
### Prerequisites
 
- Flutter installed on your machine
 
### Installation
 
- Clone the repository:  git clone https://mlmvps@dev.azure.com/mlmvps/MobileApp%20Common%20Features/_git/MCF-IC-All-Mobile
Navigate to the Flutter folder and select required project.

- Install dependencies: flutter pub get
- Run the application: flutter run
- For detailed instructions on Flutter installation, please refer to the document "Flutter Installation Guide" located in the root level "Documents" folder.

- This provides users with a clear reference point for Flutter installation instructions.
 
 
## Usage
 
Navigate through the app screens to view and search for employees, sync data, and configure settings.
 
 
## Dependencies
Include the key dependencies in your pubspec.yaml file:
 
dependencies:
  flutter:
sqflite: ^2.0.0
  path: ^1.8.0
  http: ^0.13.4
  sqflite_common_ffi: any
  provider: ^6.0.5

## Contact Information
  If any integration issues comes, please contact to these mail id: pratyusha.mettu@motivitylabs.com, srivani.ankam@motivitylabs.com,
 
 
License
This project is licensed under the [Your License] - see the LICENSE.md file for details.