import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/create_account_screen.dart';

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
        title: const Text("Login"),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("/background.jpg"),
            fit: BoxFit.cover,
          ),
          color:
              Color.fromRGBO(255, 255, 255, 0.5), // Set the transparency to 50%
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Sign in to continue.',
                    textAlign: TextAlign.center,
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
                            border: OutlineInputBorder(),
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
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
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
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateAccount()),
                              );
                            },
                            child: const Text('Create Account'),
                          ),
                        ),
                        const SizedBox(height: 16),
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
    );
  }
}
