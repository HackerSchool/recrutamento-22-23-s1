import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './main.dart';

class OnboardingPage extends StatefulWidget{
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
        controller: controller,
        onPageChanged: (index){
          setState(() => isLastPage = index == 2);
        },
        children: [ 
          //first page
          Container(
            color: Color.fromARGB(220, 3, 58, 75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Logo.png',
                  fit: BoxFit.cover,
                  width: 250,),
                const SizedBox(height: 10,),
                Text(
                  'Arede App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30 ),
                  child: Text(
                    'This app will help you to save some money in the end '+ 
                    'of the month. On the next pages we will tell you how to work ' +
                    'with this app.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),)
                ),   
              ],
            ),
          ),
          //second page
          Container(
            color: Color.fromARGB(220, 3, 58, 75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Page1.PNG',
                  fit: BoxFit.cover,
                  width: 350,),
                 
              ],
            ),
          ),
          //third page
          Container(
            color: Color.fromARGB(220, 3, 58, 75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Page2.PNG',
                  fit: BoxFit.cover,
                  width: 350,),
              ],
            ),
          )

        ],
      ),
      ),
      bottomSheet: isLastPage
      ? TextButton(child: const Text('Get Started',style: TextStyle(color: Color.fromARGB(255, 225, 240, 245),fontSize: 24),), 
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),),
        primary: Colors.white,
        backgroundColor: Color.fromARGB(255, 3, 58, 75),
        minimumSize: const Size.fromHeight(90)
        ),
      onPressed: () async {
        Navigator.push(context,
              MaterialPageRoute(builder: (cpntext) => MyApp()));
          setState(() {});
      })
      :
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 50 ),
        color: Color.fromARGB(255, 3, 58, 75),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: () => controller.previousPage(
              duration: const Duration(milliseconds: 500),
               curve: Curves.easeOut),
              child: const Text('PREVIOUS',style: TextStyle(color: Color.fromARGB(255, 203, 230, 238),),)),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                  spacing: 16,
                  dotColor: Colors.black26,
                  activeDotColor: Colors.teal.shade700,
                ),
                onDotClicked: (index) => controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn
                ),
              ),
            ),
            TextButton(onPressed: () => controller.nextPage(
              duration: const Duration(milliseconds: 500),
               curve: Curves.easeInOut),
              child: const Text('NEXT',style: TextStyle(color: Color.fromARGB(255, 203, 230, 238)))),
          ],
        ),
      ),

    );
  }
}