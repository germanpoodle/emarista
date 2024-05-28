import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:emarista_app/services/supabase_config.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _facultyIdController = TextEditingController();
  String _role = 'User'; // Default role
  final _supabaseClient = Supabase.instance.client;
  bool _isPasswordMatch = true;

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _contactNumberController.dispose();
    _addressController.dispose();
    _facultyIdController.dispose();
    super.dispose();
  }

  void _validatePassword() {
    setState(() {
      _isPasswordMatch =
          _passwordController.text == _confirmPasswordController.text;
    });
  }

  Future<void> _createAccount() async {
    if (_formKey.currentState!.validate()) {
      final idNumber = _idController.text;
      final password = _passwordController.text;
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final contactNumber = _contactNumberController.text;
      final address = _addressController.text;
      final facultyId = _facultyIdController.text;

      // Map role names to their corresponding IDs
      final roleIdMap = {'User': 1, 'Faculty': 2};
      final roleId = roleIdMap[_role] ?? 1;

      try {
        // Check if the user already exists based on role and ID
        try {
          final existingUser = _role == 'User'
              ? await _supabaseClient
                  .from('student_user')
                  .select()
                  .eq('id_number', idNumber)
                  .single()
              : await _supabaseClient
                  .from('faculty_user')
                  .select()
                  .eq('faculty_id', facultyId)
                  .single();

          if (existingUser['error'] != null) {
            // Handle error if there's any
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Error: ${existingUser['error']['message']}')),
            );
          } else {
            // Check if data is present
            final userData = existingUser['data'];
            if (userData != null) {
              // User already exists
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text('A user with the provided ID already exists')),
              );
            } else {
              // User does not exist, continue with creating the account
              // Rest of your code...
            }
          }
        } catch (error) {
          // Catch any errors that might occur during data retrieval
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        }

        if (_role == 'User') {
          // Insert into student_user table
          final response = await _supabaseClient.from('student_user').insert([
            {
              'id_number': idNumber,
              'first_name': firstName,
              'last_name': lastName,
              'contact_number': contactNumber,
              'password': password,
            }
          ]);

          if (response.error != null) {
            throw response.error!.message;
          }

          // Get the generated ID from the inserted row
          final userId = response.data![0]['id'];

          // Insert into users table with the generated ID
          await _supabaseClient.from('users').insert([
            {
              'role_id': roleId,
              'student_id': userId,
              'password': password,
              'first_name': firstName,
              'last_name': lastName,
              'contact_number': contactNumber,
              'created_at': DateTime.now().toIso8601String(),
            }
          ]);
        } else if (_role == 'Faculty') {
          // Insert into faculty_user table
          final response = await _supabaseClient.from('faculty_user').insert([
            {
              'faculty_id': facultyId,
              'address': address,
              'first_name': firstName,
              'last_name': lastName,
              'contact_number': contactNumber,
              'password': password,
            }
          ]);

          if (response.error != null) {
            throw response.error!.message;
          }

          // Get the generated ID from the inserted row
          final userId = response.data![0]['id'];

          // Insert into users table with the generated ID
          await _supabaseClient.from('users').insert([
            {
              'role_id': roleId,
              'faculty_id': userId,
              'password': password,
              'first_name': firstName,
              'last_name': lastName,
              'contact_number': contactNumber,
              'created_at': DateTime.now().toIso8601String(),
            }
          ]);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account created successfully')),
        );
        // Navigate to the login screen or home screen after successful sign-up
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create"),
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome Marista',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Create and Sign up.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'CREATE AN ACCOUNT',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _role,
                            decoration: InputDecoration(
                              labelText: 'Role',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            items:
                                <String>['User', 'Faculty'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _role = newValue!;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          if (_role == 'User') ...[
                            TextFormField(
                              controller: _idController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                labelText: 'ID Number',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your ID Number';
                                }
                                return null;
                              },
                            ),
                          ] else ...[
                            TextFormField(
                              controller: _facultyIdController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                labelText: 'Faculty ID',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Faculty ID';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _addressController,
                              decoration: InputDecoration(
                                labelText: 'Address',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Address';
                                }
                                return null;
                              },
                            ),
                          ],
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your First Name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Last Name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _contactNumberController,
                            decoration: InputDecoration(
                              labelText: 'Contact Number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Contact Number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: _isPasswordMatch
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your Password';
                              } else if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          if (!_isPasswordMatch)
                            Text(
                              'Passwords do not match',
                              style: TextStyle(color: Colors.red),
                            ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: _createAccount,
                                child: const Text('Sign Up'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _formKey.currentState!.reset();
                                  _idController.clear();
                                  _passwordController.clear();
                                  _confirmPasswordController.clear();
                                  _firstNameController.clear();
                                  _lastNameController.clear();
                                  _contactNumberController.clear();
                                  _addressController.clear();
                                  _facultyIdController.clear();
                                  setState(() {
                                    _role = 'User';
                                    _isPasswordMatch = true;
                                  });
                                },
                                child: const Text('Reset'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
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
