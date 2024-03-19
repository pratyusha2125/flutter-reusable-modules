import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'Home_page.dart';
import 'constants.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage({
    required String title,
    required String subtitle,
  }) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Centered Logo at the top
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(
              child: Image.asset(
                constants.motivityLogo,
                width: 200, // Set the width of your logo
                height: 200, // Set the height of your logo
              ),
            ),
          ),
          // Page Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color.fromARGB(255, 226, 123, 20),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 70),
        child: PageView(
          controller: controller,
          onPageChanged: (value) {
            setState(() => isLastPage = value == 3);
          },
          children: [
            buildPage(
              // color: Colors.grey,
              // Image: api_constants.motivityLogo,
              title: 'Profile',
              subtitle:
                  'Explore your profile details and personalize your information. Update your profile effortlessly to reflect the latest changes and keep your account information up-to-date.',
            ),
            buildPage(
                // color: Colors.grey,
                // Image: api_constants.motivityLogo,
                title: 'Settings',
                subtitle:
                    'Personalize the theme, language, and font settings for a tailored interface. Explore seamless synchronization features to ensure your data is always up-to-date across devices.'),
            buildPage(
                // color: Colors.white,
                // Image: api_constants.motivityLogo,
                title: 'Maps',
                subtitle:
                    'In this screen, explore the power of Google Maps. Discover your current location, plan routes from source to destination, and navigate seamlessly through your surroundings.'),
            buildPage(
                // color: Colors.grey,
                // Image: api_constants.motivityLogo,
                title: 'Payments',
                subtitle:
                    'Explore the convenience of secure and seamless payments within the app. Experience hassle-free transactions,and enjoy a smooth financial experience. Your payments, simplified.'),
            Container(
              color: Colors.grey,
              child: Center(),
            ),
            Container(
              color: Colors.grey,
              child: Center(),
            ),
            Container(
              color: Colors.grey,
              child: Center(),
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal()),
                backgroundColor: const Color.fromARGB(255, 226, 123, 20),
                minimumSize: const Size.fromHeight(65),
              ),
              onPressed: () async {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ));
              },
              child: Text(
                'Get Started',
              ))
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => controller.jumpToPage(3),
                      child: Text('Skip',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 226, 123, 20)))),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 4,
                      effect: const WormEffect(
                        spacing: 16,
                        dotColor: Colors.black26,
                        activeDotColor: Color.fromARGB(255, 226, 123, 20),
                      ),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  TextButton(
                      onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      child: Text('Next',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 226, 123, 20)))),
                ],
              ),
            ),
    );
  }
}
