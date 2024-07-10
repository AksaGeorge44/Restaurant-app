import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/cart_provider.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider=Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          if (cartProvider.cartItems.isEmpty) {
            return Center(
              child: Text('Your cart is empty'),
            );
          }
          return ListView.builder(
            itemCount: cartProvider.cartItems.length,
            itemBuilder: (context, index) {
              final product = cartProvider.cartItems[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      // Container(
                      //   width: 80,
                      //   height: 80,
                      //   child: Image.asset(
                      //     product.imageUrl,
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text('Price: ₹${product.price}'),
                            if (product.discount > 0)
                              Text(
                                'Discount: ${product.discount}%',
                                style: TextStyle(color: Colors.red),
                              ),
                            Row(
                              children: [
                                Text('Quantity:'),
                                SizedBox(width: 8),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () => cartProvider.decreaseProductQuantity(product),
                                    ),
                                    Text('${product.quantity}'),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () => cartProvider.increaseProductQuantity(product),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => cartProvider.removeItem(product),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, _) => Text(
                'Total: ₹${cartProvider.getTotalPrice()}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Implement place order functionality
                _showOrderPlacedDialog(context);
              },
              child: Text('Place Order'),
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderPlacedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order Placed Successfully!'),
        content: Text('Your order will be delivered soon.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/')); // Pop until HomeScreen
              // Clear cart state
              Provider.of<CartProvider>(context, listen: false).clearCart();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
