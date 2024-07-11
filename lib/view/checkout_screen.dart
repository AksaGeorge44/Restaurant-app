import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/cart_provider.dart';
import '../model/category.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final List<Product> cartItems = cartProvider.cartItems;


    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Price: ₹${product.price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          cartProvider.decreaseProductQuantity(product);
                        },
                      ),
                      Text('${product.quantity}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          cartProvider.addToCart(product);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: ₹${cartProvider.getTotalPrice().toStringAsFixed(2)}'),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Order successfully placed!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    cartProvider.clearCart();

                    Navigator.of(context).pop();
                  },
                  child: const Text('Checkout'),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

