import 'package:flutter/material.dart';
import 'lib/screens/login_screen.dart';


void main() {
  runApp(const LoginAccount());
}

class LoginAccount extends StatelessWidget {
  const LoginAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "test",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
