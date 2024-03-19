import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_userprofiledemo/homePage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_userprofiledemo/theme/api_constants.dart';


class Login extends StatefulWidget {
  const Login({super.key,required this.title,});
  final String title;
  static const route = '/Login';

  @override
  State<Login> createState() => _LoginState();
}

Future<void> saveTokenLocally(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

class _LoginState extends State<Login> {
  String? _token;
  bool _isChecked = false;
  bool _isObscure = true;


  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }


  dynamic globalResponseData;

  void loginUser() async {
    var url = api_constants.login;
    var data = {
      "email": emailController.text,
      "password": passwordController.text,
    };
    var bodyy = json.encode(data);
    var urlParse = Uri.parse(url);
    try {
      http.Response response = await http.post(urlParse,
          body: bodyy, headers: {"Content-Type": "application/json"});

      globalResponseData = response.body;
      final Map<String, dynamic> userData = json.decode(response.body);

      print(userData["accessToken"]);
      if (response.statusCode == 200) {
        // Remove token from local storage
        saveTokenLocally("token", userData["accessToken"]);
        saveTokenLocally("email", userData["email"]);
        saveTokenLocally("userName", userData["userName"]);

        // Successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        showSuccessDialog(context);
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Login(title: ''),
            )); // Unsuccessful login
        showErrorDialog(
          context,
          "Invalid credentials. Please try again.",
          
        );
      }
    } catch (error) {
      // Handle network or other errors
      print("Error: $error");
      showErrorDialog(context, "An error occurred. Please try again later.",
         
          );
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 226, 123, 20),
        title: Text(
          "Login",
         
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  api_constants.motivityLogo,
                  height: 75,
                  width: 200,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                 
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      loginUser();
                      if (_formKey.currentState!.validate()) {
                        if (emailController.text != "" &&
                            passwordController.text != "") {
                         

                          showSuccessDialog(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Invalid Credentials',
                                style: TextStyle(
                                 
                                ),
                              ),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please fill input',
                              style: TextStyle(
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 226, 123, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
             ],
          ),
        ),
      ),

    );
  }
}


  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Login Successful",
            ),
          content: Text(
            "You have successfully logged in!",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
               ),
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, String errorMessage,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Login Failed",
             ),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
              ),
            ),
          ],
        );
      },
    );
  }
