# flutter_calendardemo


## Description

This Flutter application allows users to manage events, including creating, viewing, and deleting events. It utilizes Google Calendar API for event management.

## Features


- **Calendar Feature:**
  - Select a particular date on the calendar.
  - Add new events with details like name, location, date, and time.
  - Create, view, and delete events for the selected date.
  


## Getting Started

Follow these steps to get your project up and running:

### Prerequisites

- Flutter installed on your machine

### Installation

- Clone the repository: git clone https://mlmvps@dev.azure.com/mlmvps/MobileApp%20Common%20Features/_git/MCF-IC-All-Mobile
  Navigate to the Flutter folder and select required project.

- Install dependencies: flutter pub get
- Run the application: flutter run
- For detailed instructions on Flutter installation, please refer to the document "Flutter Installation Guide" located in the root level "Documents" folder.

- This provides users with a clear reference point for Flutter installation instructions.

Authentication
-The app uses email and password authentication to access the Google Calendar API. Upon successful authentication, the app retrieves a token from  the server and stores it locally using shared preferences. This token is then used to authenticate subsequent API requests.

## Usage


-Open the app on your device.
-Log in using your email and password.
-Upon successful login, the app will access the token and grant access to the event calendar.
-Navigate to the calendar screen to view events.
-Add new events by tapping on the "Add" button and providing event details.
-Delete events by entering the event ID and tapping on the "Delete" button.

## Dependencies
Include the key dependencies in your pubspec.yaml file:

dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2
  table_calendar: ^3.0.9
  intl: ^0.18.1
  http: ^0.13.4
 
## Contact Information
  If any integration issues comes, please contact to these mail id: pratyusha.mettu@motivitylabs.com, srivani.ankam@motivitylabs.com,


License
This project is licensed under the [Your License] - see the LICENSE.md file for details.

<!-- A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference. -->
