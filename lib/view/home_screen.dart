import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskproject/controller/cart_provider.dart';
import 'package:taskproject/view/checkout_screen.dart';
import '../controller/category_provider.dart';
import '../controller/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Taza Kitchen'),
        backgroundColor: Colors.blue.shade100,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ),
                  );
                },
              ),
              Consumer<CartProvider>(
                builder: (ctx, cartProvider, _) {
                  if (cartProvider.totalItems > 0) {
                    return Positioned(
                      right: 4,
                      top: 4,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          '${cartProvider.totalItems}',
                          style: const TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(user?.displayName ?? 'User'),
              accountEmail: Text(user?.phoneNumber ?? user?.email ?? ''),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  user?.displayName != null ? user!.displayName![0].toUpperCase() : 'U',
                  style: const TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () async {
                exit(0);
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            _buildRestaurantInfo(),
            Expanded(child: _buildCategoryList(context, cartProvider)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildRestaurantInfo() {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/rest_images.jpg'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Taza Kitchen', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('From Peyad'),
                    Row(
                      children: [
                        Text('Member Since Aug 16, 2021'),
                        SizedBox(width: 8),
                        Icon(Icons.verified, color: Colors.blue),
                      ],
                    ),
                    Text('FSSAI No: 21231317700450'),
                  ],
                ),
                Spacer(),
              ],
            ),
            const SizedBox(height: 10),
            Card(
              child: Container(
                color: Colors.teal.shade50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildInfoColumn('14', 'Posts'),
                    _buildInfoColumn('37', 'Followers'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildTabBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String count, String label) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label),
      ],
    );
  }

  Widget _buildTabBar() {
    return DefaultTabController(
      length: 5,
      child: Container(
        color: Colors.grey[200],
        child: const TabBar(
          tabs: [
            Tab(text: 'Wall'),
            Tab(text: 'Menu'),
            Tab(text: 'Videos'),
            Tab(text: 'Reviews'),
            Tab(text: 'Blog'),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList(BuildContext context, CartProvider cartProvider) {
    return FutureBuilder(
      future: Provider.of<CategoryProvider>(context, listen: false).fetchCategories(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('An error occurred!'));
        } else {
          return Consumer<CategoryProvider>(
            builder: (ctx, categoryProvider, _) => ListView.builder(
              itemCount: categoryProvider.categories.length,
              itemBuilder: (ctx, index) {
                final category = categoryProvider.categories[index];
                return ExpansionTile(
                  title: Text(category.name),
                  children: category.products.map((product) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Text('(${product.minQty} min qty)', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Text('Price: ₹${product.price}'),
                                  if (product.discount > 0)
                                    Text(
                                      'Discount: ${product.discount}%',
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    if (product.quantity > 0) {
                                      cartProvider.decreaseProductQuantity(product);
                                    }
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
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return BottomAppBar(
      child: Container(
        color: Colors.blue.shade300,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<CartProvider>(
                builder: (ctx, cartProvider, _) {
                  return Text('${cartProvider.totalItems} Items');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ),
                  );
                },
                child: const Text('View Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
