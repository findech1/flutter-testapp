import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Ordering App',
      theme: ThemeData(
        primarySwatch: Colors.teal, // Chroma color
      ),
      home: const FoodMenuPage(),
    );
  }
}

class FoodMenuPage extends StatefulWidget {
  const FoodMenuPage({Key? key}) : super(key: key);

  @override
  _FoodMenuPageState createState() => _FoodMenuPageState();
}

class _FoodMenuPageState extends State<FoodMenuPage> {
  final List<Map<String, dynamic>> _foodItems = [
    {'name': 'Pizza', 'price': 10.99},
    {'name': 'Burger', 'price': 8.99},
    {'name': 'Salad', 'price': 6.99},
    {'name': 'Pasta', 'price': 12.99},
    {'name': 'Sushi', 'price': 15.99},
    {'name': 'Sandwich', 'price': 7.99},
    {'name': 'Cake', 'price': 9.99},
  ];

  final Map<String, int> _cart = {};

  void addToCart(String itemName) {
    setState(() {
      if (_cart.containsKey(itemName)) {
        _cart[itemName] = _cart[itemName]! + 1;
      } else {
        _cart[itemName] = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Menu'),
      ),
      body: ListView.builder(
        itemCount: _foodItems.length,
        itemBuilder: (BuildContext context, int index) {
          final foodItem = _foodItems[index];
          return FoodItemCard(
            itemName: foodItem['name'],
            itemPrice: foodItem['price'],
            onPressed: () {
              addToCart(foodItem['name']);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to cart screen
        },
        label: Text(
          'Cart: ${_cart.values.reduce((sum, value) => sum + value)} items',
        ),
        icon: Icon(Icons.shopping_cart),
      ),
    );
  }
}

class FoodItemCard extends StatelessWidget {
  final String itemName;
  final double itemPrice;
  final VoidCallback onPressed;

  const FoodItemCard({
    required this.itemName,
    required this.itemPrice,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(itemName),
        subtitle: Text('\$$itemPrice'),
        trailing: ElevatedButton(
          onPressed: onPressed,
          child: const Text('Add to Cart'),
        ),
      ),
    );
  }
}
