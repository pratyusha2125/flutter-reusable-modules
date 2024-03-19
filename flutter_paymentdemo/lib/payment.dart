import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_paymentdemo/homePage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart'; 
import 'package:flutter_paymentdemo/theme/api_constants.dart';


class PaymentScreen extends StatefulWidget {

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  
  final formkey = GlobalKey<FormState>();

  int _currentIndex = 0;
  bool _validate = false;
  bool _autoValidate = true;
  bool userExists = false;
  String namePattern = r'^[a-zA-Z]+$';
  String phoneNumberPattern = r'^([6-9])(?!\1{9})[0-9]{9}$';

   void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController plinkIdController = TextEditingController();

  void handlePayment(int rupees) async {
    try {
      // Assuming APIs.payments is defined elsewhere in your code
      int amountInPaise = rupees * 100;
      final response = await http.post(
        Uri.parse(api_constants.payments),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'amount': amountInPaise,
          'name': nameController.text,
          'contact': contactController.text,
          'email': emailController.text,
          'plinkId': int.parse(plinkIdController.text),
        }),
      );

      final orderData = jsonDecode(response.body);
      print('response data: $orderData');
      print('response success data: ${response.statusCode}');
      if (response.statusCode == 200) {
        showSnackbar(context, 'Payment successful!');

        await launch(orderData["short_url"]);
        // await storePaymentURI('short_url');
        // await launch('short_url');
      } else {
        showSnackbar(context, 'Payment failed. Please try again.');
      }

      setState(() {
        amountController.clear();
        nameController.clear();
        contactController.clear();
        emailController.clear();
        plinkIdController.clear();
      });
    } catch (error) {
      print('Error fetching Razorpay order details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // or Colors.black if isDarkMode is true
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 123, 20), // or Colors.white if isDarkMode is true
        title: Text('Payment Screen'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomePage()));
          },
      ),
      ),
            body: SingleChildScrollView(
            reverse: true,
            child: Form(
              key: formkey,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: TextFormField(
                      key:  Key('Name'),
                      controller: nameController,
                      
                      decoration:  InputDecoration(
                          border: OutlineInputBorder(),
                          // labelText: 'FirstName',
                          hintText: 'Enter your name',
                         
                      ),
                      validator: (value) => validateName(value!),
                      autovalidateMode: _autoValidate ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,

                      
                      
                  ),
                  ),
                   Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration:  InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your email',
                         
                        ),
                        validator: (value) => validateEmail(value!),
                        autovalidateMode: _autoValidate ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,

                      )),
                Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: TextFormField(
                        controller: contactController,
                        decoration:  InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your ContactNumber',
                        ),
                        validator: (value) => validatePhoneNumber(value!),
                        autovalidateMode: _autoValidate ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,

                      )),
                      Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: TextFormField(
                        controller: amountController,
                        decoration:  InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your Amount',
                        ),
                        validator: (value) => validateAmount(value!),
                        autovalidateMode: _autoValidate ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,

                      )),
                        Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: TextFormField(
                        controller: plinkIdController,
                        decoration:  InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your 3 digit PlinkId',
                        ),
                        validator: (value) => validatePlinkId(value!),
                        autovalidateMode: _autoValidate ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,

                      )),
                  ElevatedButton(
                    onPressed:  () async {
                       setState(() {
                             _autoValidate = false; // Disable automatic validation after submission
                      });
                      if (formkey.currentState?.validate() == true) {
                        int rupees=1;
                     handlePayment(rupees);
                     }
                        
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 226, 123, 20)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ))),
                    child:  Text(
                      'make payment',
                      style: TextStyle(
                        color: Colors.white,
                      
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom))
                ],
              ),
          ),
            ),
             bottomNavigationBar: BottomNavigationBar(
               selectedItemColor: Colors.black,
               unselectedItemColor: const Color.fromARGB(255, 226, 123, 20),
               currentIndex: 1, // Index 2 corresponds to SettingsPage
               onTap: (int index) {
               if (index == 0) {
                Navigator.pushReplacement(
                  context,
                MaterialPageRoute(
                    builder: (context) => HomePage())
                    );
             } else if (index == 1) {
            setState(() {
              _currentIndex = index;
            });
           }
        },
          
         items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
         BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'payments',
          ),
          ],
        ),
      );
    }

   String? validateEmail(String value) {
    String emailPattern = r'@.*\.com$';
    RegExp regExp = RegExp(emailPattern);

    if (!regExp.hasMatch(value)) {
      return 'please enter email address';
    }
  }

  String? validateName(String value) {
    RegExp regExp = RegExp(namePattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid name';
    }
  }

  String? validatePhoneNumber(String value) {
    RegExp regExp = RegExp(phoneNumberPattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
  }
  String? validateAmount(String value) {
      if (value.isEmpty) {
      return 'Please enter the amount';
    }
    // Parse the entered amount as an integer
    if (double.tryParse(value) == null) {
    return 'Please enter a valid number';
  }

  // Parse the entered amount as a double
  double enteredAmount = double.parse(value);

  // Check if the entered amount is greater than or equal to 1 (in rupees)
  if (enteredAmount < 1) {
    return 'Amount must be greater than or equal to 1 rupee';
  }

 return null;
  
  
  }

  String? validatePlinkId(String value) {
    if (value.isEmpty) {
      return 'Please enter your PlinkId';
    }
    // Parse the Plink Id to check if it's a valid integer
  try {
    int plinkId = int.parse(value);
    // Check if the Plink Id is a positive integer with up to 3 digits
    if (plinkId < 0 || plinkId > 999) {
      return 'Plink Id must be a positive number with up to 3 digits';
    }
  } catch (error) {
    // Handle parsing error
    return 'Invalid Plink Id';
  }
    // Add PlinkId validation logic here
    return null;
  }
}


























