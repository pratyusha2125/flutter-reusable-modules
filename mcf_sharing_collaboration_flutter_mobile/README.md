# Your Sharing And Collaboration

## Description

Welcome to Your Flutter Sharing and Collaboration App! This application offers users the ability to capture photos and record videos directly within the app. Users can view and manage their media in-app and easily share selected photos or videos to various social media platforms. Additionally, all captured media is stored in the device gallery for convenient access. This README provides an overview of the app's features, installation instructions, usage guidelines, and dependencies.

## Features

- **Media Capture:**
  - Capture photos within the app.
  - Record videos directly from the application.

- **Media Viewing:**
  - View and manage all captured photos and videos within the app.

- **Media Sharing:**
  - Share selected photos or videos to external social media platforms.


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

**Media Capture:**

Take Photo:

Navigate to the app's main screen.
Click the "Take Photo" button to capture a photo using the device camera.

Record Video:
Click the "Record Video" button to start recording a video using the device camera.
Stop recording when done.

**Media Viewing:**

View All Media:
Navigate to the "View All Media" section in the app.
Browse and manage all captured photos and videos.

**Media Sharing:**

Share Media:
Within the "View All Media" section, tap on a photo or video to select it.
Click the "Share Media" button to share the selected media to external social media platforms.

## Dependencies
Include the key dependencies in your pubspec.yaml file:

dependencies:

  flutter:
    sdk: flutter
  image_picker: ^0.8.6
  gallery_saver: ^2.0.4
  path_provider: ^2.0.15
  share: ^2.0.4

 
## Contact Information
 For any integration issues, please contact:

    Srivani Ankam: srivani.ankam@motivitylabs.com
    Pratyusha Mettu: pratyusha.mettu@motivitylabs.com


License
This project is licensed under the MIT License - see the LICENSE.md file for details.