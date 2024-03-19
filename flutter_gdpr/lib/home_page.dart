import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  bool _isChecked = false;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _showIntialDialog();
    });
  }

  void _showIntialDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(
                "GDPR",
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20),
                    //text for the dialog box
                    Text(
                      "By checking this box, you agree to our GDPR policy.Our GDPR policy includes the following:- We collect and process your personal data responsibly and transparently - Your data is used only for specified and legitimate purposes - We implement the security measures to protect you data - You have the right to access,rectify, and erase your data For more details,please refer to our full GDPR policy on our website.",
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                          activeColor: Colors.blue,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          checkColor: Colors.white,
                        ),
                        SizedBox(height: 20),
                        Flexible(
                          child: Text(
                            "I agree to the terms and conditions",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    //   Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: TextButton(
                    //       onPressed: (){
                    //         Navigator.of(context).pop();
                    //       },
                    //       child: Text("Close"),
                    //     ),
                    //   )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: _isChecked
                      ? () {
                          Navigator.of(context).pop();
                          if (_isChecked) {
                            _performCheckboxAction();
                          }
                        }
                      : null,
                  child: Text(
                    "OK",
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _performCheckboxAction() {
    print("Checkbox is checked. Perform your action here.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: const Color.fromARGB(255, 226, 123, 20),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
