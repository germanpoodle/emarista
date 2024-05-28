import 'package:flutter/material.dart';
import 'package:flutter_application_7/screens/Orders.dart';
import 'package:flutter_application_7/screens/stocks.dart';
import 'package:flutter_application_7/screens/transactions.dart';
import 'package:flutter_application_7/screens/users.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AdminPage(),
        '/stocks': (context) => StocksPage(),
        '/users': (context) => UsersPage(),
        '/orders': (context) => OrdersPage(),
        '/transactions': (context) => TransactionsScreen(),
      },
    );
  }
}

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    StocksPage(),
    UsersPage(),
    OrdersPage(),
    TransactionsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pop(context); // close the drawer
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // handle notifications
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // handle settings
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, size: 40, color: Colors.black),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('John Doe',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('johndoe@example.com',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600])),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: Icon(Icons.inventory),
              title: Text('Stocks'),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Users'),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: Text('Orders'),
              onTap: () => _onItemTapped(3),
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Transactions'),
              onTap: () => _onItemTapped(4),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text('Welcome to the Admin Dashboard'),
      ),
    );
  }
}
