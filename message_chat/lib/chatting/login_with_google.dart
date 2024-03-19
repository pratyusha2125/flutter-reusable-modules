import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:message_chat/chatting/api/apis.dart';
import 'package:message_chat/chatting/chat_home_screen.dart';
import 'package:message_chat/chatting/chat_user.dart';

class LoginWithGoogle extends StatefulWidget {
  const LoginWithGoogle({super.key});

  @override
  State<LoginWithGoogle> createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userEmail = "";
  static User get user => auth.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login With Google"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 226, 123, 20),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("User Email: "),
                  Text(userEmail.isNotEmpty ? userEmail : "Not signed in")
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  // await _signInWithGoogle();

                  // setState(() {});
                  _handleGoogleBtnClick();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 226, 123, 20)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ))),
                child: Text("Login with google")),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  userEmail = "";
                  await GoogleSignIn().signOut();
                  setState(() {});
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 226, 123, 20)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ))),
                child: Text("Logout"))
          ],
        ),
      ),
    );
  }

  // handles google login button click
  _handleGoogleBtnClick() {
    _signInWithGoogle().then((user) async {
      // //for hiding progress bar
      // Navigator.pop(context);

      if (user != null) {
        print('\nUser: ${user.user}');
        print('\nUserAdditionalInfo: ${user.additionalUserInfo}');

        if ((await APIs.userExists())) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const ChatHomeScreen()));
        } else {
          await APIs.createUser().then((value) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const ChatHomeScreen()));
          });
        }
      }
    }).catchError((error) {
      // Handle errors during the Google sign-in process
      print("Google Sign-In Error: $error");
      // You can display a snackbar or show an error message to the user
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      //user cancelled the google sign-in
      return null;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    userEmail = googleUser.email ?? ""; 

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // for checking if user exists or not?
}
