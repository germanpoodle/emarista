import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:emarista_app/screens/create_account_screen.dart';
import 'package:emarista_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _supabase = Supabase.instance.client;

  String? studID;
  String? password;

  Future<bool> _login(String studID, String password) async {
  try {
    // Fetch all student_user records
    var onError;

    final response = await _supabase
      .from('student_user')
      .select('*').catchError(onError);

  final users = response.data;
  final error = response.error;

  if (error != null) {
    print('Error fetching student_user data: ${error.message}');
  } else {
    print('Fetched student_user data: $users');
  }
}

    final studentUsers = studentResponse.data as List<dynamic>;
    // Check if the provided studID and password match any entry in the student_user table
    final studentUser = studentUsers.firstWhere(
      (user) => user['student_id'] == studID && user['password'] == password,
      orElse: () => null,
    );

    if (studentUser != null) {
      // User found in student_user table
      final userId = studentUser['student_id'];

      // Insert into users table
      final insertResponse = await _supabase.from('users').insert([
        {'users_id': userId, 'student_ID': studID}
      ]).execute();

      if (insertResponse.error == null) {
        // Insert successful
        return true;
      } else {
        // Failed to insert into users table
        print('Failed to insert into users table: ${insertResponse.error?.message}');
        return false;
      }
    }

    // Fetch all faculty_user records
    final facultyResponse = await _supabase
        .from('faculty_user')
        .select('*')
        ;

    if (facultyResponse.error != null) {
      print('Error fetching faculty_user data: ${facultyResponse.error?.message}');
      return false;
    }

    final facultyUsers = facultyResponse.data as List<dynamic>;
    // Check if the provided studID and password match any entry in the faculty_user table
    final facultyUser = facultyUsers.firstWhere(
      (user) => user['facultyID'] == studID && user['password'] == password,
      orElse: () => null,
    );

    if (facultyUser != null) {
      // User found in faculty_user table
      final userId = facultyUser['facultyID'];

      // Insert into users table
      final insertResponse = await _supabase.from('users').insert([
        {'users_id': userId, 'faculty_ID': studID}
      ]);

      if (insertResponse.error == null) {
        // Insert successful
        return true;
      } else {
        // Failed to insert into users table
        print('Failed to insert into users table: ${insertResponse.error?.message}');
        return false;
      }
    }

    // User not found in either table
    print('User not found in either student_user or faculty_user table');
    return false;
  } catch (error) {
    print('Error during login: $error');
    return false;
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "/Users/gabz_1/Desktop/eMARISTA/emarista_app/assets/background.jpg"),
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
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        'WELCOME BACK MARISTA',
                        style: TextStyle(
                          fontSize: 25,
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
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your ID number';
                              }
                              return null;
                            },
                            onSaved: (value) => studID = value,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            onSaved: (value) => password = value,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                print(
                                    'Attempting login with ID: $studID'); // Debugging line
                                bool isLoggedIn =
                                    await _login(studID!, password!);
                                if (isLoggedIn) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()),
                                  );
                                } else {
                                  // Handle login failure
                                  print('Login failed'); // Debugging line
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Login Failed'),
                                        content: const Text(
                                            'Failed to log in. Please check your credentials and try again.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            child: const Text('Login'),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                                side: const BorderSide(color: Colors.black),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: const BorderSide(
                                      color: Colors.black, width: 1),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CreateAccount(),
                                  ),
                                );
                              },
                              child: const Text('Create Account'),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                                side: const BorderSide(color: Colors.black),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: const BorderSide(
                                      color: Colors.black, width: 1),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                              onPressed: () {},
                              child: const Text('Forgot password?'),
                            ),
                          )
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
