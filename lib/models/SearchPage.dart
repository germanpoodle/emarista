import 'package:flutter/material.dart';
import 'package:flutter_application_6/models/AddProductPage.dart';
import 'package:flutter_application_6/models/CartPage.dart'; // Import AddProductPage

class SearchPage extends StatefulWidget {
  final List<Map<String, dynamic>> items;

  SearchPage({required this.items});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> _searchResults = [];
  TextEditingController _searchController = TextEditingController();

  // Function to search items
  void _searchItems(String query) {
    List<Map<String, dynamic>> results = [];

    // Loop through items and check if query matches any item name
    for (var item in widget.items) {
      if (item['name'].toLowerCase().contains(query.toLowerCase())) {
        results.add(item);
      }
    }

    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: _searchItems,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_searchResults[index]['name']),
            // Inside the onTap method of the ListTile in the ListView.builder of SearchPage
            onTap: () async {
              final selectedProduct = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProductPage(
                    productName: _searchResults[index]['name'],
                    productImage: _searchResults[index]['image'],
                    productPrice: _searchResults[index]['price'],
                  ),
                ),
              );
              // Check if a product was returned from AddProductPage
              if (selectedProduct != null) {
                // Add the selected product to the cart
                setState(() {
                  CartPage.cartItems.add(selectedProduct);
                });
              }
            },
          );
        },
      ),
    );
  }
}
