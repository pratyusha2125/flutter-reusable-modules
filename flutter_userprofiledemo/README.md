# flutter_userprofiledemo



## Description

The Flutter Profile App allows users to view and edit their profile details. Users can update their first name, last name, and contact number. The app utilizes HTTP requests to fetch and update user profiles, and it allows users to login using their email and password to access their profile details securely.

## Features


- **Profile Management:**
  - User authentication with email and password
  - Fetch user profile details using an access  token stored in shared preferences.
  - View and edit user profile information.
  - Edit first name, last name, and contact number.
  - Save changes to the profile
  





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



## Usage
Run the application:
flutter run

Open the app on your device.
Login using your email and password.
Upon successful login, your access token will be stored in shared preferences.
Your profile details will be fetched using the stored access token.
View your profile details.
Tap on the "Edit Profile" button to enter edit mode.
Update your first name, last name, and contact number.
Tap on the "Save Profile" button to save your changes or tap on "Cancel" to discard changes.
Navigate to other screens using the bottom navigation bar.

## Dependencies
Include the key dependencies in your pubspec.yaml file:

dependencies:
  flutter:
    sdk: flutter
 get:
 
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
