import 'package:flutter/material.dart';
import 'package:prepo/cart_page.dart';
import 'package:prepo/models/cart.dart'; // Import your cart model
import 'package:uuid/uuid.dart'; // To generate unique IDs

class BuildMealPage extends StatefulWidget {
  const BuildMealPage({super.key});

  @override
  _BuildMealPageState createState() => _BuildMealPageState();
}

class _BuildMealPageState extends State<BuildMealPage> {
  String? selectedBase = 'Rice';
  String? selectedProtein = 'Chicken';
  List<String> selectedToppings = [];
  List<String> selectedExtras = [];

  final List<String> bases = ['Rice', 'Noodles', 'Lettuce'];
  final List<String> proteins = ['Chicken', 'Beef', 'Tofu'];
  final List<String> toppings = ['Tomatoes', 'Onions', 'Olives', 'Cheese'];
  final List<String> extras = ['Avocado', 'Sauce', 'Spices'];

  final double mealPrice = 900.0;

  void addMealToCart() {
  final mealId = const Uuid().v4(); // Generate unique ID

  final mealName =
      '${selectedBase ?? ''} + ${selectedProtein ?? ''} + ${selectedToppings.join(', ')} + ${selectedExtras.join(', ')}';

  final CartItem customMeal = CartItem(
    id: mealId,
    name: mealName,
    price: mealPrice,
  );

  Cart().addItem(customMeal);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text('Build Your Meal'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Choose Your Base',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ...bases.map((base) {
                return RadioListTile<String>(
                  title: Text(base),
                  value: base,
                  groupValue: selectedBase,
                  onChanged: (value) {
                    setState(() {
                      selectedBase = value;
                    });
                  },
                );
              }),
              const SizedBox(height: 20),

              const Text('Choose Your Protein',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ...proteins.map((protein) {
                return RadioListTile<String>(
                  title: Text(protein),
                  value: protein,
                  groupValue: selectedProtein,
                  onChanged: (value) {
                    setState(() {
                      selectedProtein = value;
                    });
                  },
                );
              }),
              const SizedBox(height: 20),

              const Text('Choose Your Toppings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ...toppings.map((topping) {
                return CheckboxListTile(
                  title: Text(topping),
                  value: selectedToppings.contains(topping),
                  onChanged: (isSelected) {
                    setState(() {
                      if (isSelected!) {
                        selectedToppings.add(topping);
                      } else {
                        selectedToppings.remove(topping);
                      }
                    });
                  },
                );
              }),
              const SizedBox(height: 20),

              const Text('Choose Your Extras',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ...extras.map((extra) {
                return CheckboxListTile(
                  title: Text(extra),
                  value: selectedExtras.contains(extra),
                  onChanged: (isSelected) {
                    setState(() {
                      if (isSelected!) {
                        selectedExtras.add(extra);
                      } else {
                        selectedExtras.remove(extra);
                      }
                    });
                  },
                );
              }),
              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  addMealToCart();

                  // Navigate to Cart Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
                child: const Text('Add to Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
