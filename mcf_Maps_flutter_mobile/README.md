# Your Flutter Maps Application

## Description

Welcome to Your Flutter Maps Application! This application enables users to plan routes, view distances, and access Google Maps navigation seamlessly. Users can enter source and destination locations, view the route on the map, check their current location, and start navigation using Google Maps. This README provides an overview of the app's features, installation instructions, usage guidelines, and dependencies.
## Features

- **Google Maps Feature:**

- **Maps Functionality:**
  - Enter source and destination locations.
  - View the distance between source and destination.
  - Display the route as a polyline on the map.

- **Current Location:**
  - Find and display the user's current location on the map.

- **Google Maps Navigation:**
   - Redirect users to Google Maps for turn-by-turn navigation.


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

Enter Source and Destination:

Open the app and navigate to the "Maps" screen.
Enter the source and destination locations in the provided input fields.

View Route:
Click on the "search" button to view the route (polyline) on the map.

Current Location:
Click the "Current Location" button to view your current location on the map.

Start Navigation:
After entering source and destination, click the "Start Navigation" button.
The app will redirect you to Google Maps for navigation.

## Dependencies
Include the key dependencies in your pubspec.yaml file:

dependencies:
  flutter:
    sdk: flutter
  google_maps_flutter: ^2.5.0
  geolocator: ^10.1.0
  geocoding: ^2.1.1
  uuid: ^4.2.1
  url_launcher: ^6.0.13
  flutter_polyline_points: ^1.0.00
  search_map_place_updated: ^0.0.4
  flutter_svg: ^2.0.9
  http: ^0.13.0
  google_maps_webservice: ^0.0.20-nullsafety.5

 
## Contact Information
 For any integration issues, please contact:

    Srivani Ankam: srivani.ankam@motivitylabs.com
    Pratyusha Mettu: pratyusha.mettu@motivitylabs.com
    


License
This project is licensed under the MIT License - see the LICENSE.md file for details.