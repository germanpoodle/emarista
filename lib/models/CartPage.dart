import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  static List<Map<String, dynamic>> cartItems = [];

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<int> _selectedItems = [];

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedItems.contains(index)) {
        _selectedItems.remove(index);
      } else {
        _selectedItems.add(index);
      }
    });
  }

  void _removeSelectedItems() {
    setState(() {
      CartPage.cartItems.removeWhere(
          (item) => _selectedItems.contains(CartPage.cartItems.indexOf(item)));
      _selectedItems.clear();
    });
  }

  void _clearCart() {
    setState(() {
      CartPage.cartItems.clear();
      _selectedItems.clear();
    });
  }

  double _calculateTotalAmount() {
    double totalAmount = 0;
    for (var item in CartPage.cartItems) {
      totalAmount += item['price'];
    }
    return totalAmount;
  }

  void _verifyPurchase(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Verify Purchase'),
          content: Text('Are you sure you want to make this purchase?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _generateReceipt(context);
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _generateReceipt(BuildContext context) {
    // Generate receipt and navigate to receipt page
    final receipt = {
      'items': List<Map<String, dynamic>>.from(
          CartPage.cartItems), // Copy the cart items
      'totalAmount': _calculateTotalAmount(),
      'dateTime': DateTime.now(),
    };
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReceiptPage(receipt: receipt),
      ),
    );
    // Clear cart after generating receipt
    _clearCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: _clearCart,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _selectedItems.isEmpty ? null : _removeSelectedItems,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: CartPage.cartItems.length,
              itemBuilder: (context, index) {
                final item = CartPage.cartItems[index];
                final isSelected = _selectedItems.contains(index);
                return ListTile(
                  leading: Image.network(
                    item['image'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.red,
                          size: 50,
                        ),
                      );
                    },
                  ),
                  title: Text(item['name']),
                  subtitle: Text(
                    'Size: ${item['size'] ?? 'N/A'}, Quantity: ${item['quantity']}, Price: ₱${item['price']}',
                  ),
                  trailing: Text(
                    'Date: ${item['date']}\nTime: ${item['time']}',
                    textAlign: TextAlign.right,
                  ),
                  tileColor: isSelected ? Colors.lightGreenAccent : null,
                  onTap: () => _toggleSelection(index),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total Amount: ₱${_calculateTotalAmount().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _verifyPurchase(context);
            },
            child: Text('Buy'),
          ),
        ],
      ),
    );
  }
}

class ReceiptPage extends StatelessWidget {
  final Map<String, dynamic> receipt;

  ReceiptPage({required this.receipt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Receipt Details:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Total Amount: ₱${receipt['totalAmount'].toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Date and Time: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(receipt['dateTime'])}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Items:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: receipt['items'].length,
                itemBuilder: (context, index) {
                  final item = receipt['items'][index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item['name']}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Size: ${item['size'] ?? 'N/A'}, Quantity: ${item['quantity']}, Price: ₱${item['price'].toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
