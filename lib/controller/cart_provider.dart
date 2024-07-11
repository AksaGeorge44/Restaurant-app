import 'package:flutter/material.dart';
import '../model/category.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    final index = _cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      product.quantity = 1;
      _cartItems.add(product);
    }
    notifyListeners();
  }

  void removeItem(Product product) {
    _cartItems.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }

  void decreaseProductQuantity(Product product) {
    final index = _cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  void increaseProductQuantity(Product product) {
    final index = _cartItems.indexWhere((item) => item.id == product.id);
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

  int get totalItems {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
