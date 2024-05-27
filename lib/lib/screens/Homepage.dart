import 'package:flutter/material.dart';
import 'package:flutter_application_6/models/AddProductPage.dart';
import 'package:flutter_application_6/models/CartPage.dart';
import 'package:flutter_application_6/models/SearchPage.dart';

class Homepage extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      'name': 'Polo',
      'image':
          'https://filebroker-cdn.lazada.com.ph/kf/S402069780f5f4c80b982840b9245beaaD.jpg',
      'price': 900.0,
    },
    {
      'name': 'Pants',
      'image':
          'https://filebroker-cdn.lazada.com.ph/kf/Sb12c7ce6c59044b1acc5a2a0635213d8R.jpg',
      'price': 1200.0,
    },
    {
      'name': 'Blouse',
      'image': 'https://i.ebayimg.com/images/g/fP8AAOSwSMRgRzSF/s-l1200.jpg',
      'price': 900.0,
    },
    {
      'name': 'Skirt',
      'image':
          'https://m.media-amazon.com/images/I/71fDXnmyhIL._AC_UY1100_.jpg',
      'price': 1200.0,
    },
    {
      'name': 'Nursing Kit',
      'image':
          'https://scontent.xx.fbcdn.net/v/t1.15752-9/436668550_968146868268765_3926846625998221520_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeGdz3AK8FX6zXTR5IT9nufCzmtmQIXJj6rOa2ZAhcmPqj_ZQE8uhZ1gQgedFT1J2Eq8LqYjlWdeyK7iHz5PSx3O&_nc_ohc=ldHTPQL36gcQ7kNvgHUaccY&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=03_Q7cD1QG8RS-XU3V9fHJX6CMmxq5OZ7etKmBLwWLlFGuNNjjPiA&oe=667ABE67',
      'price': 1000.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping App'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Shopping App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(items: items),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                // Navigate to Profile page
              },
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxItemWidth = 200;
          int crossAxisCount = (constraints.maxWidth / maxItemWidth).floor();

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.7,
            ),
            padding: EdgeInsets.all(8.0),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  final product = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProductPage(
                        productName: items[index]['name'],
                        productImage: items[index]['image'],
                        productPrice: items[index]['price'],
                      ),
                    ),
                  );
                  if (product != null) {
                    CartPage.cartItems.add(product);
                  }
                },
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(items[index]['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          items[index]['name'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
