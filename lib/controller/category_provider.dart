import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/category.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  Future<void> fetchCategories() async {
    final url = Uri.parse('https://yip-dev.techbutomy.com/api/category-list');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<Category> loadedCategories = [];
        final List<dynamic> responseData = json.decode(response.body)['category'];
        responseData.forEach((categoryData) {
          final category = Category.fromJson(categoryData);

          loadedCategories.add(category);
        });
        _categories = loadedCategories;
        notifyListeners();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      throw error;
    }
  }

  void increaseProductQuantity(Category category, Product product) {
    product.quantity += 1;
    notifyListeners();
  }

  void decreaseProductQuantity(Category category, Product product) {
    if (product.quantity > 0) {
      product.quantity -= 1;
      notifyListeners();
    }
  }

  int getTotalItems() {
    int total = 0;
    for (var category in _categories) {
      for (var product in category.products) {
        total += product.quantity;
      }
    }
    return total;
  }
}
