import 'package:flutter/material.dart';

void main() {
  runApp(ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}

class Product {
  final String name;
  final String image;
  final String description;
  final double price;

  Product({
    required this.name,
    required this.image,
    required this.description,
    required this.price,
  });
}

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Product> products = [
    Product(
      name: "Shoes",
      image:
          "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
      description: "Comfortable running shoes for daily use.",
      price: 2999,
    ),
    Product(
      name: "Watch",
      image:
          "https://images.unsplash.com/photo-1516574187841-cb9cc2ca948b",
      description: "Stylish wrist watch with premium design.",
      price: 1999,
    ),
    Product(
      name: "Headphones",
      image:
          "https://images.unsplash.com/photo-1518444028785-8c9bcb04e4d3",
      description: "Noise-cancelling over-ear headphones.",
      price: 1499,
    ),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Product selectedProduct = products[selectedIndex];

    return Scaffold(
      appBar: AppBar(title: Text("Shopping App")),
      body: Column(
        children: [
          // MAIN IMAGE
          Container(
            height: 250,
            padding: EdgeInsets.all(10),
            child: Image.network(selectedProduct.image),
          ),

          // NAME
          Text(
            selectedProduct.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          // PRICE
          Text(
            "₹${selectedProduct.price}",
            style: TextStyle(fontSize: 20, color: Colors.green),
          ),

          // DESCRIPTION (Dynamic)
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              selectedProduct.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),

          SizedBox(height: 10),

          // PRODUCT SELECTOR (Grid)
          Expanded(
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedIndex == index
                            ? Colors.blue
                            : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Image.network(products[index].image),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
