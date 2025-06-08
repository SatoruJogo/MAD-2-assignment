import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';
import 'cart_page.dart';
import 'build_meal_page.dart';
import 'about_page.dart';
import 'profile_page.dart';
import 'faq_page.dart';
import 'contact_us_page.dart';

import 'models/cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  bool isLoggedIn = false;
  List<dynamic> products = [];
  List<dynamic> filteredProducts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    fetchProducts();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  Future<void> fetchProducts() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/products');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          products = data;
          filteredProducts = data;
        });
      } else {
        debugPrint('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching products: $e');
    }
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = products.where((product) {
        final name = product['name'].toString().toLowerCase();
        return name.contains(query);
      }).toList();
    });
  }

  Future<void> addToCart(String productId) async {
    final product = products.firstWhere((p) => p['id'].toString() == productId);

    Cart().addItem(CartItem(
      id: productId,
      name: product['name'] ?? 'No Name',
      price: double.tryParse(product['price'].toString()) ?? 0.0,
      quantity: 1,
    ));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product['name']} added to cart')),
    );
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    setState(() {
      isLoggedIn = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prepo'),
        elevation: 0,
      ),
      drawer: Drawer(
        backgroundColor: Colors.green[700],
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text('Prepo', style: TextStyle(color: Colors.white, fontSize: 32)),
            ),
            isLoggedIn
                ? ListTile(
                    leading: const Icon(Icons.logout, color: Colors.white),
                    title: const Text('Logout', style: TextStyle(color: Colors.white)),
                    onTap: logout,
                  )
                : _buildDrawerItem(Icons.login, 'Login', context, const LoginPage()),
            _buildDrawerItem(Icons.shopping_cart, 'Cart', context, const CartPage()),
            _buildDrawerItem(Icons.restaurant, 'Build Meal', context, const BuildMealPage()),
            _buildDrawerItem(Icons.person, 'Profile', context, const ProfilePage()),
            _buildDrawerItem(Icons.info, 'About Us', context, const AboutPage()),
            _buildDrawerItem(Icons.question_answer, 'FAQ', context, const FAQPage()),
            _buildDrawerItem(Icons.contact_mail, 'Contact Us', context, const ContactUsPage()),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search products...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            Expanded(
              child: filteredProducts.isEmpty
                  ? const Center(child: Text('No products found'))
                  : ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return ProductCard(
                          productId: product['id'].toString(),
                          name: product['name'] ?? 'No Name',
                          price: double.tryParse(product['price'].toString()) ?? 0.0,
                          imageUrl: product['image_path'] ?? '',
                          onAddToCart: addToCart,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()));
                },
              ),
              IconButton(
                icon: const Icon(Icons.build, color: Colors.white),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const BuildMealPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context, Widget page) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ProductCard extends StatelessWidget {
  final String productId;
  final String name;
  final double price;
  final String imageUrl;
  final Future<void> Function(String) onAddToCart;

  const ProductCard({
    super.key,
    required this.productId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 80),
                  )
                : const Icon(Icons.broken_image, size: 80),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('\$${price.toStringAsFixed(2)}'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => onAddToCart(productId),
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
