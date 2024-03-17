import 'package:flutter/material.dart';

class Cart {
  List<CartItem> _items = [];

  void addItem(String name, int quantity, double price) {
    _items.add(CartItem(name, quantity, price));
  }

  void removeItem(int index) {
    _items.removeAt(index);
  }

  List<CartItem> get items => _items;

  double get totalPrice => _items.fold(0, (total, current) => total + (current.price * current.quantity));
}

class CartItem {
  String name;
  int quantity;
  double price;

  CartItem(this.name, this.quantity, this.price);
}

void main() {
  runApp(HomePage());
}

class Homepage extends StatelessWidget {
  final Cart _cart = Cart();

  Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomePage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(cart: _cart),
      routes: {
        '/product-details': (context) {
          final entry = ModalRoute.of(context)!.settings.arguments as MapEntry<String, String>;
          return ProductDetailsPage(entry: entry, cart: _cart);
        },
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Cart cart;

  MyHomePage({required this.cart});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = [
      HomePage(),
      SearchPage(),
      CartPage(cart: widget.cart),
      AccountPage(),
    ];
  }

  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Commerce App'),
        backgroundColor: Colors.blue,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border(
            top: BorderSide(
              color: Colors.grey[300]!,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    onTabTapped(0);
                  },
                ),
                Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.white,fontSize: 12,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    onTabTapped(1);
                  },
                ),
                Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    onTabTapped(2);
                  },
                ),
                Text(
                  'Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () {
                    onTabTapped(3);
                  },
                ),
                Text(
                  'Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class HomePage extends StatelessWidget {
  final Map<String, String> _shirtImages = {
    'polo':
        'https://filebroker-cdn.lazada.com.ph/kf/S402069780f5f4c80b982840b9245beaaD.jpg',
    'Pants':
        'https://filebroker-cdn.lazada.com.ph/kf/Sb12c7ce6c59044b1acc5a2a0635213d8R.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: _shirtImages.entries.map((entry) {
        return GestureDetector(
          onTap: () {
            // Navigate to the product details page when a user taps on a shirt
            Navigator.pushNamed(
              context,
              '/product-details',
              arguments: entry,
            );
          },
          child: GridTile(
            child: Image.network(entry.value, fit: BoxFit.cover),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(entry.key),
              subtitle: Text('\₱20.00'),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            // Implement search functionality here
          },
        ),
      ),
      body: Center(
        child: Text('Search Page'),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CartPage extends StatefulWidget {
  final Cart cart;

  CartPage({required this.cart});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: widget.cart.items.isEmpty
          ? Center(
              child: Text('Cart is empty'),
            )
          : ListView.builder(
              itemCount: widget.cart.items.length,
              itemBuilder: (context, index) {
                final item = widget.cart.items[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('Quantity: ${item.quantity}'),
                  trailing: Text('\₱${item.price * item.quantity}'),
                  onTap: () {
                    // Remove itemfrom cart when user taps on it
                    setState(() {
                      widget.cart.removeItem(index);
                    });
                  },
                );
              },
            ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border(
            top: BorderSide(
              color: Colors.grey[300]!,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Text(
                  'Total: ₱${widget.cart.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Clear cart when user taps on the clear cart button
                    setState(() {
                      widget.cart.items.clear();
                    });
                  },
                  child: Text('Clear Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child:Text('Account Page'),
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  static Route route(MapEntry<String, String> entry, {required Cart cart}) {
    return MaterialPageRoute<void>(
      builder: (_) => ProductDetailsPage(entry: entry, cart: cart),
      settings: RouteSettings(
        arguments: entry,
      ),
    );
  }

  final MapEntry<String, String> entry;
  final Cart cart;

  // Add a new constructor that takes a non-const entry argument
  ProductDetailsPage({Key? key, required this.entry, required this.cart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entry.key),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(entry.value, fit: BoxFit.cover, height: 300),
              SizedBox(height: 16),
              Text(entry.key),
              SizedBox(height: 16),
              Text('\₱20.00'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  cart.addItem(entry.key, 1, 20.00);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added to cart')),
                  );
                },
                child: Text('Add to Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}