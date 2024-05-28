import 'package:flutter/material.dart';
import 'package:flutter_application_7/screens/Orders.dart';
import 'package:flutter_application_7/screens/stocks.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<String> _users = [
    'John Doe',
    'Jane Doe',
    'Bob Smith',
    'Alice Johnson',
  ];

  final _formKey = GlobalKey<FormState>();

  void _navigateToStocks() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StocksPage()),
    ).then((value) {
      if (value != null && value == true) {
        // The user has updated the stock, so refresh the page
        setState(() {});
      }
    });
  }

  void _navigateToUsers() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UsersPage()),
    );
  }

  void _navigateToOrders() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrdersPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: _users.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(_users[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
