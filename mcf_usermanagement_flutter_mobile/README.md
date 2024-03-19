# Your Flutter User Management App

## Description

Welcome to Your Flutter User Management App! This application provides user management functionality, allowing users to register, log in, and recover their passwords. Additionally, users can utilize social logins, such as Google, for a seamless authentication experience. This README provides an overview of the app's features, installation instructions, usage guidelines, and dependencies.
## Features

- **User Registration:**
  - Users can register by providing necessary information.

- **User Login:**
  - Registered users can log in using their credentials.

- **Forgot Password:**
  - Users can recover their password by providing their email address.

- **Social Logins:**
  - Users can log in using Google for a simplified authentication process.


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

**User Registration:**

Click the "Sign Up" button on the initial screen.
Provide the required information (name, email, password) in the registration form.
Click the "Register" button to create a new account.

**User Login:**

After registering, click the "Log In" button on the initial screen.
Enter your email and password to log in.

**Forgot Password:**

If you forget your password, click the "Forgot Password" button on the login screen.
Enter your registered email address.
Check your email for a code and follow the instructions to reset your password.

**Social Logins:**

Click the "Login with Google" button for a quick login using your Google account.

## Dependencies
Include the key dependencies in your pubspec.yaml file:

dependencies:

   flutter:
    sdk: flutter
  firebase_auth: ^latest_version # For Firebase authentication
  google_sign_in: ^latest_version # For Google sign-in functionality
 
## Contact Information
 For any integration issues, please contact:

    Srivani Ankam: srivani.ankam@motivitylabs.com
    Pratyusha Mettu: pratyusha.mettu@motivitylabs.com


License
This project is licensed under the MIT License - see the LICENSE.md file for details.