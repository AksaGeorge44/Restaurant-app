class Category {
  final int id;
  final String name;
  final List<Product> products;

  Category({required this.id, required this.name, required this.products});

  factory Category.fromJson(Map<String, dynamic> json) {
    var productsJson = json['product'] as List;
    List<Product> productList = productsJson.map((product) => Product.fromJson(product)).toList();

    return Category(
      id: json['id'],
      name: json['name'],
      products: productList,
    );
  }
}

class Product {
  final int id;
  final String name;
  final double price;
  final int discount;
  final int minQty;
  int quantity; // Add this line

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.minQty,
    this.quantity = 0, // Default quantity is 0
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      discount: json['discount'],
      minQty: json['min_qty'],
    );
  }
}

