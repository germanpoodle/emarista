import 'package:flutter/material.dart';
import 'package:flutter_application_7/screens/stocks.dart';
import 'package:flutter_application_7/screens/users.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<String> _orders = [
    'Order 1',
    'Order 2',
    'Order 3',
    'Order 4',
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

  void _navigateToOrders() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrdersPage()),
    );
  }

  void _navigateToUsers() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UsersPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: _orders.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(_orders[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Handle order deletion here
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
