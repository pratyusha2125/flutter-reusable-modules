# Your Flutter Messaging and Chat App

## Description

Welcome to Your Flutter Messaging and Chat App! This application enables users to connect with friends, sending messages, emojis, and images seamlessly. Users can log in with their Google account, access a home screen displaying all available users, and select specific chats for communication. The app supports sending text messages, emojis, and images. Additionally, users can sign out from their Google account directly within the app. This README provides an overview of the app's features, installation instructions, usage guidelines, and dependencies.

## Features

- **Login with Google:**
  - Log in to the app using a Google account.

- **chat Home Screen:**
  - Access a home screen displaying all available users for chatting.

- **Chatting Functionality:**
  - Select a user to start a chat.
  - Send text messages, emojis, and images in the chat.

- **Sign Out:**
  - Log out from the Google account within the app.


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

**Login:**

Click the "Login with Google" button on the initial screen.
Log in with your Google account.

**Chat Home Screen:**

After logging in, you will be directed to the chat home screen.
View all available users for chatting.

**Start a Chat:**

Select a user from the list to start a chat.

**Chatting:**

In the chat screen, type text messages in the input field.
Use the emoji picker to send emojis.
Click the image icon to send images from your device.

**Sign Out:**

Click the "Sign Out" button to log out from your Google account.

## Dependencies
Include the key dependencies in your pubspec.yaml file:

dependencies:

 flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  font_awesome_flutter: ^10.6.0
  firebase_auth: ^4.10.1
  firebase_core: ^2.17.0
  google_sign_in: ^6.1.5
  cloud_firestore: ^4.1.0
  cached_network_image: ^3.3.1
  emoji_picker_flutter: ^1.5.1
  image_picker: ^0.8.6
  gallery_saver: ^2.0.4
  path_provider: ^2.0.15
  share: ^2.0.4
  video_player: ^2.6.1
  audioplayers: ^5.2.1
  assets_audio_player: ^3.0.3
  file_picker: ^4.0.4
  chewie: ^1.2.2
  firebase_storage: ^11.0.6
  flutter_rating_bar: ^4.0.1
  get:

 
## Contact Information
 For any integration issues, please contact:

    Srivani Ankam: srivani.ankam@motivitylabs.com
    Pratyusha Mettu: pratyusha.mettu@motivitylabs.com


License
This project is licensed under the MIT License - see the LICENSE.md file for details.