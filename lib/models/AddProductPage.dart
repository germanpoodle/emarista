import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddProductPage extends StatefulWidget {
  final String productName;
  final String productImage;
  final double productPrice;

  AddProductPage({
    required this.productName,
    required this.productImage,
    required this.productPrice,
  });

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _currentDateTime;
  String? _selectedSize;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _currentDateTime = DateTime.now();
    _updateCurrentDateTime();
  }

  void _updateCurrentDateTime() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _currentDateTime = DateTime.now();
        });
        _updateCurrentDateTime();
      }
    });
  }

  void _addToCart(BuildContext context) {
    final product = {
      'name': widget.productName,
      'image': widget.productImage,
      'size': _selectedSize,
      'quantity': _quantity,
      'price': widget.productPrice * _quantity,
      'date': DateFormat('yyyy-MM-dd').format(_currentDateTime),
      'time': DateFormat('HH:mm:ss').format(_currentDateTime),
    };
    // Return to the previous page with the added product
    Navigator.pop(context, product);
  }

  @override
  Widget build(BuildContext context) {
    bool isSizeSelectable =
        ['Polo', 'Pants', 'Blouse', 'Skirt'].contains(widget.productName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Image.network(
                widget.productImage,
                height: 150,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Text(
                widget.productName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Price: \$${widget.productPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              if (isSizeSelectable)
                DropdownButtonFormField<String>(
                  value: _selectedSize,
                  decoration: InputDecoration(labelText: 'Select Size'),
                  items: ['Small', 'Medium', 'Large']
                      .map((size) => DropdownMenuItem<String>(
                            value: size,
                            child: Text(size),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSize = value;
                    });
                  },
                ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Quantity'),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (_quantity > 1) _quantity--;
                          });
                        },
                      ),
                      Text(_quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Current Date'),
                  Text(DateFormat('yyyy-MM-dd').format(_currentDateTime)),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Current Time'),
                  Text(DateFormat('HH:mm:ss').format(_currentDateTime)),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addToCart(context);
                    },
                    child: Text('Add to Cart'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
