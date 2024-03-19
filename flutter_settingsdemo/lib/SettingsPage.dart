import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_settingsdemo/homePage.dart';
import 'package:get/get.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
 
  int _currentIndex = 0;
  double fontSize = 15.0;
  TextEditingController fontSizeController = TextEditingController();
  
  Locale? selectedLocale = Get.locale;
  bool isDarkMode = false;
  

  final List<Map<String, dynamic>> locale = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': '中国人', 'locale': Locale('cn', 'CH')},
    {'name': 'Deutsch', 'locale': Locale('de', 'GR')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
    setState(() {
      selectedLocale = locale;
    });
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      Get.changeTheme(isDarkMode ? ThemeData.dark() : ThemeData.light());
    });
  }

  void increaseFontSize(double newFontSize) {
    setState(() {
      if (fontSizeController.text.isNotEmpty) {
        fontSize = double.parse(fontSizeController.text);
      } else {
        fontSize += 5.0;
      }
      GetConfig().setFontSize(fontSize);
      // fontSize += 5.0;
    });
  }

  void changeFontSize(double newFontSize) {
    setState(() {
      if (fontSizeController.text.isNotEmpty) {
        fontSize = double.parse(fontSizeController.text);
       
      } else {
        fontSize = newFontSize;
        
      }
      GetConfig().setFontSize(fontSize);
      
    });
  }

  buildDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Text('Choose a language'),
          content: Container(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      print(locale[index]['name']);
                      updateLanguage(locale[index]['locale']);
                    },
                    child: Text(locale[index]['name']),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.blue,
                );
              },
              itemCount: locale.length,
            ),
          ),
        );
      },
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Success'.tr,
            style: TextStyle(fontSize: GetConfig().currentFontSize),
          ),
          content: Text(
            'Data inserted successfully'.tr,
            style: TextStyle(fontSize: GetConfig().currentFontSize),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK'.tr,
                style: TextStyle(fontSize: GetConfig().currentFontSize),
              ),
            ),
          ],
        );
      },
    );
  }

 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 226, 123, 20),
        title: Text(
          'Settings'.tr,
          style: TextStyle(fontSize: GetConfig().currentFontSize),
        ),
       
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
           Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage(email: '')),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Theme:'.tr,
                      style: TextStyle(fontSize: GetConfig().currentFontSize),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 120,
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: ElevatedButton(
                      onPressed: toggleTheme,
                      child: Center(
                        child: Text('Light\nDark'.tr,
                            style: TextStyle(
                                fontSize: GetConfig().currentFontSize)),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 226, 123, 20)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ))),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Font Change:'.tr,
                      style: TextStyle(fontSize: GetConfig().currentFontSize),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 226, 123, 20),
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: TextField(
                      controller: fontSizeController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          double newFontSize =
                              double.parse(fontSizeController.text);
                          if (newFontSize >= 1 && newFontSize <= 24) {
                            changeFontSize(newFontSize);
                          } else {
                            fontSizeController.text = '15.0';
                            changeFontSize(15.0);
                          }
                        } else {
                          changeFontSize(15.0);
                        }
                      },
                      // },
                      decoration: InputDecoration(
                        labelText: '',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Change Language:'.tr,
                      style: TextStyle(fontSize: GetConfig().currentFontSize),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 120,
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 226, 123, 20),
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        buildDialog(context);
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 226, 123, 20)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ))),
                      child: Text(
                        'Change Language'.tr,
                        style: TextStyle(fontSize: GetConfig().currentFontSize),
                      ),
                    ),
                  ),
                ],
              ),
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
           
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomePage(email: '')));
         
          } else if (index == 1) {
            setState(() {
              _currentIndex = index;
            });
        
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings'.tr,
          ),
         
          
        ],
        selectedLabelStyle: TextStyle(fontSize: GetConfig().currentFontSize),
        unselectedLabelStyle: TextStyle(fontSize: GetConfig().currentFontSize),
      )
      );
      }

  
}

class GetConfig extends GetxController {
  RxDouble fontSize = 15.0.obs;

  double get currentFontSize => fontSize.value;

  void setFontSize(double newSize) {
    fontSize.value = newSize;
    update();
  }

  static GetConfig _instance = GetConfig._internal();

  factory GetConfig() {
    return _instance;
  }

  GetConfig._internal();
}
