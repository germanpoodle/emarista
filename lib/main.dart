import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const LoginAccount());
}

class LoginAccount extends StatelessWidget {
  const LoginAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "test",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ToLoginPage(),
    );
  }
}

class ToLoginPage extends StatefulWidget {
  const ToLoginPage({Key? key}) : super(key: key);

  @override
  LoginPage createState() => LoginPage();
}

class LoginPage extends State<ToLoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _idNumber;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-MARISTA"),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.yellow,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(8),
                      child: const Text(
                        'WELCOME BACK MARISTA',
                        style: TextStyle(
                          fontSize: 64,
                          color: Color.fromARGB(255, 55, 240, 86),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'SIGN IN TO CONTINUE.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        color: Color.fromARGB(255, 62, 245, 69),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(13),
                            ],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'ID Number',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your ID number';
                              }
                              return null;
                            },
                            onSaved: (value) => _idNumber = value,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                            onSaved: (value) => _password = value,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                // Perform login logic here with _idNumber and _password
                                print(
                                    'ID Number: $_idNumber, Password: $_password');
                              }
                            },
                            child: const Text('Sign In'),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('Forgot password?'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
