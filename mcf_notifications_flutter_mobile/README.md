# Your Flutter Push Notifications App

## Description

Welcome to Your Flutter Push Notifications App! This application enables users to receive push notifications using Firebase Cloud Messaging (FCM). Notifications are sent from Firebase, and users can receive them even when the application is running in the background or terminated. Clicking on a notification will open the application. This README provides an overview of the app's features, installation instructions, usage guidelines, and dependencies.

## Features

- **Push Notifications:**
  - Receive push notifications from Firebase Cloud Messaging.


## Getting Started

Follow these steps to get your project up and running:

### Prerequisites

- Flutter installed on your machine
- Firebase project with Firebase Cloud Messaging (FCM) set up.

### Installation

- Clone the repository: git clone https://mlmvps@dev.azure.com/mlmvps/MobileApp%20Common%20Features/_git/MCF-IC-All-Mobile
  Navigate to the Flutter folder and select required project.

- Install dependencies: flutter pub get
- configure Firebase: 
    Create a Firebase project on the Firebase Console.
    Add your Android and iOS apps to the project.
    Download and add the google-services.json file for Android and GoogleService-Info.plist for iOS to the respective app folders.
    Enable Firebase Cloud Messaging (FCM) in the Firebase project settings.
    Retrieve the FCM server key and update your app's code.

- Run the application: flutter run
- For detailed instructions on Flutter installation, please refer to the document "Flutter Installation Guide" located in the root level "Documents" folder.

- This provides users with a clear reference point for Flutter installation instructions.


## Usage

**Push Notifications:**

    Ensure your app is configured to receive notifications from Firebase Cloud Messaging.
    Send a notification from Firebase Cloud Messaging.
    Users will receive notifications even when the app is running in the background or terminated.
    Clicking on a notification will open the application.


## Dependencies
Include the key dependencies in your pubspec.yaml file:

dependencies:

 flutter:
    sdk: flutter
  firebase_core: ^latest_version # For Firebase integration
  firebase_messaging: ^latest_version # For Firebase Cloud Messaging

 
## Contact Information
 For any integration issues, please contact:

    Srivani Ankam: srivani.ankam@motivitylabs.com
    Pratyusha Mettu: pratyusha.mettu@motivitylabs.com


License
This project is licensed under the MIT License - see the LICENSE.md file for details.