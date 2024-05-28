import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showPasswordContent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts Center'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: NavigationPane(
              onSelect: (selected) {
                setState(() {
                  showPasswordContent = selected == 'Password and security';
                });
              },
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: showPasswordContent
                  ? PasswordContent()
                  : PersonalDetailsContent(
                      isFaculty: true,
                      role: 'Faculty',
                      fullName: 'John Doe',
                      idNumber: '123456',
                      contactNumber: '555-1234',
                      address: '123 Main St, Anytown, USA',
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationPane extends StatelessWidget {
  final ValueChanged<String> onSelect;

  NavigationPane({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: [
        ListTile(
          title: Text('Password and security'),
          onTap: () => onSelect('Password and security'),
        ),
        ListTile(
          title: Text('Personal details'),
          onTap: () => onSelect('Personal details'),
        ),
      ],
    );
  }
}

class PasswordContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Password and security',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          title: Text('Change password'),
          onTap: () {
            // Handle Change password
          },
        ),
      ],
    );
  }
}

class PersonalDetailsContent extends StatelessWidget {
  final bool isFaculty;
  final String role;
  final String fullName;
  final String idNumber;
  final String contactNumber;
  final String address;

  PersonalDetailsContent({
    required this.isFaculty,
    required this.role,
    required this.fullName,
    required this.idNumber,
    required this.contactNumber,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Personal Details',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          title: Text('Role: $role'),
        ),
        ListTile(
          title: Text('Full Name: $fullName'),
        ),
        ListTile(
          title: Text('ID Number: $idNumber'),
        ),
        ListTile(
          title: Text('Contact Number: $contactNumber'),
        ),
        ListTile(
          title: Text('Address: $address'),
        ),
      ],
    );
  }
}
