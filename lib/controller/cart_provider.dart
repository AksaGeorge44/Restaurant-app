import 'package:flutter/cupertino.dart';

import '../model/category.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeItem(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void decreaseProductQuantity(Product product) {
    final index = _cartItems.indexOf(product);
    if (index != -1 && _cartItems[index].quantity > 0) {
      _cartItems[index].quantity--;
      notifyListeners();
    }
  }

  void increaseProductQuantity(Product product) {
    final index = _cartItems.indexOf(product);
    if (index != -1) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  double getTotalPrice() {
    double totalPrice = 0;
    for (var product in _cartItems) {
      totalPrice += product.price * product.quantity;
    }
    return totalPrice;
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
