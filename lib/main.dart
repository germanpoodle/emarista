import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart'; // Ensure this file is correctly imported

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "E-MARISTA",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Lottie.network(
                  'https://lottie.host/4b5a3166-80b9-4398-8053-ff2e26c8ee81/KKPhnT9m6D.json'),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Welcome to E-Marista',
            style: GoogleFonts.caveat(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            "Your Local Book Room Supplies in a Screen",
            style: GoogleFonts.robotoSlab(
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = 0.0;
                    const end = 1.0;
                    const curve = Curves.easeInOut;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var fadeAnimation = animation.drive(tween);

                    return FadeTransition(
                      opacity: fadeAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Text("Let's get started"),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
