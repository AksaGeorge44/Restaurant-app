import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskproject/controller/cart_provider.dart';
import 'package:taskproject/view/checkout_screen.dart';
import '../controller/category_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider=Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Taza Kitchen'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Implement share functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildRestaurantInfo(),
          Expanded(child: _buildCategoryList(context)),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildRestaurantInfo() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoColumn('14', 'Posts'),
              _buildInfoColumn('37', 'Followers'),
            ],
          ),
          SizedBox(height: 10,),
          _buildTabBar()
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String count, String label) {
    return Column(
      children: [
        Text(count, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

  Widget _buildCategoryList(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<CategoryProvider>(context, listen: false).fetchCategories(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('An error occurred!'));
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
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            // Container(
                            //   width: 80,
                            //   height: 80,
                            //   child: Image.asset(
                            //     product.imageUrl, // Dynamic image URL or path
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Text('(${product.minQty} min qty)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Text('Price: ₹${product.price}'),
                                  if (product.discount > 0)
                                    Text(
                                      'Discount: ${product.discount}%',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    Provider.of<CategoryProvider>(context, listen: false).decreaseProductQuantity(category, product);
                                  },
                                ),
                                Text('${product.quantity}'), // Display the current quantity
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    Provider.of<CategoryProvider>(context, listen: false).increaseProductQuantity(category, product);
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
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<CategoryProvider>(
                builder: (ctx, categoryProvider, _) {
                  return Text('${categoryProvider.getTotalItems()} Items');
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
                child: Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
