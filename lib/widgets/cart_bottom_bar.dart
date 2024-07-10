import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/auth_provider.dart';
import '../view/checkout_screen.dart';

class CartBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final cartItems = authService.cartItems;

    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Items in cart: ${cartItems.length}'),
            ElevatedButton(
              onPressed: cartItems.isNotEmpty
                  ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              }
                  : null,
              child: Text('Go to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
