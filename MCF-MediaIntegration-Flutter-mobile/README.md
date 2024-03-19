# Your Flutter Maps Application

## Description

Welcome to Your Flutter Media Integration App! This application offers users the ability to pick and play audio and video files from their devices seamlessly. Users can choose audio files, play them within the app, and control playback through the notification bar. Additionally, users can pick video files and play them directly within the application. This README provides an overview of the app's features, installation instructions, usage guidelines, and dependencies.
## Features

- **Media Integration:**

- **Audio Integration:**
  - Pick audio files from the device.
  - Play selected audio files within the application. 
  - Control audio playback through the notification bar.

- **Video Integration:**
  - Pick video files from the device.
  - Play selected video files within the application.


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

**Audio Integration:**

Pick and Play Audio:

Click the "Pick Audio" button to select an audio file from your device.
Once selected, the audio will start playing.

Control Playback:
Use the controls within the app to pause, play, or stop the audio playback.
Slide down the notification bar to see the current audio playing and control playback from there.

**Video Integration:**

Pick and Play Video:

Click the "Pick Video" button to select a video file from your device.
Once selected, the video will start playing.
Control Video Playback:

Use the video controls within the app to pause, play, or stop the video playback.

## Dependencies
Include the key dependencies in your pubspec.yaml file:

dependencies:

 flutter:
    sdk: flutter
  video_player: ^2.6.1
  audioplayers: ^5.2.1
  assets_audio_player: ^3.0.3
  file_picker: ^4.0.4
  chewie: ^1.2.2

 
## Contact Information
 For any integration issues, please contact:

    Srivani Ankam: srivani.ankam@motivitylabs.com
    Pratyusha Mettu: pratyusha.mettu@motivitylabs.com


License
This project is licensed under the MIT License - see the LICENSE.md file for details.