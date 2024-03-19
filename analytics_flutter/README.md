# Your Flutter Analytics and Tracking App

## Description

Welcome to Your Flutter Firebase Analytics App! This application integrates Firebase Analytics for tracking user behavior and interactions within the app. Firebase Analytics provides insights into screen visits, events, and other relevant metrics to understand user engagement. This README provides an overview of the app's features, installation instructions, usage guidelines, and dependencies.


## Features

- **Analytics Integration:**
  - Track screen visits and events within the application.
  - Gather data on user interactions for analysis and insights.


## Getting Started

Follow these steps to get your project up and running:

### Prerequisites

- Flutter installed on your machine.
- Firebase project created and configured with Firebase Analytics.

### Installation

- Clone the repository: git clone https://mlmvps@dev.azure.com/mlmvps/MobileApp%20Common%20Features/_git/MCF-IC-All-Mobile
  Navigate to the Flutter folder and select required project.

- Install dependencies: flutter pub get

## Configure Firebase:

- Create a Firebase project on the Firebase Console.
- Add your Android and iOS apps to the project.
- Download and add the google-services.json file for Android and GoogleService-Info.plist for iOS to the respective app folders.
## Integrate Firebase Analytics:

Follow the steps provided by Firebase to integrate Firebase Analytics into your Flutter application.

- Run the application: flutter run

- For detailed instructions on Flutter installation, please refer to the document "Flutter Installation Guide" located in the root level "Documents" folder.

- This provides users with a clear reference point for Flutter installation instructions.


## Usage
After integrating Firebase Analytics into the application, data will be automatically tracked for screen visits and events.

Access the Firebase console to view insights and metrics provided by Firebase Analytics.

## Dependencies
Include the key dependencies in your pubspec.yaml file:

dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.24.2
  firebase_analytics: ^10.7.4
  firebase_messaging: ^14.7.10
## Contact Information
  If any integration issues comes, please contact to these mail id: srivani.ankam@motivitylabs.com, pratyusha.mettu@motivitylabs.com.


License
This project is licensed under the [Your License] - see the LICENSE.md file for details.