import 'package:flutter/material.dart';
import 'package:flutter_application_7/screens/Orders.dart';
import 'package:flutter_application_7/screens/users.dart';

class StocksPage extends StatefulWidget {
  @override
  _StocksPageState createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  Map<String, int> _stock = {
    'Polo': 10,
    'Pants': 20,
    'Women\'s Blouse': 30,
    'Women\'s Skirt': 40,
  };

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView.builder(
            itemCount: _stock.length,
            itemBuilder: (context, index) {
              String item = _stock.keys.elementAt(index);
              int quantity = _stock[item]!;
              return Card(
                child: ListTile(
                  title: Text(item),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            _stock[item] = quantity - 1;
                          });
                        },
                      ),
                      Text('$quantity'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _stock[item] = quantity + 1;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
