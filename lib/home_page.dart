import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'orders_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'All';
  String searchText = '';

  final TextEditingController searchController =
      TextEditingController();

  final List<Map<String, dynamic>> foods = [
    {
      'name': 'Margherita Pizza',
      'category': 'Pizza',
      'price': '₹199',
      'icon': Icons.local_pizza,
    },
    {
      'name': 'Cheese Pizza',
      'category': 'Pizza',
      'price': '₹249',
      'icon': Icons.local_pizza,
    },
    {
      'name': 'Chicken Burger',
      'category': 'Burger',
      'price': '₹179',
      'icon': Icons.lunch_dining,
    },
    {
      'name': 'Veg Burger',
      'category': 'Burger',
      'price': '₹99',
      'icon': Icons.lunch_dining,
    },
    {
      'name': 'Veg Biryani',
      'category': 'Biryani',
      'price': '₹149',
      'icon': Icons.rice_bowl,
    },
    {
      'name': 'Chicken Biryani',
      'category': 'Biryani',
      'price': '₹199',
      'icon': Icons.rice_bowl,
    },
    {
      'name': 'Mutton Biryani',
      'category': 'Biryani',
      'price': '₹279',
      'icon': Icons.rice_bowl,
    },
    {
      'name': 'Prawns Biryani',
      'category': 'Biryani',
      'price': '₹299',
      'icon': Icons.rice_bowl,
    },
    {
      'name': 'Classic Fries',
      'category': 'Fries',
      'price': '₹79',
      'icon': Icons.fastfood,
    },
    {
      'name': 'Peri Peri Fries',
      'category': 'Fries',
      'price': '₹99',
      'icon': Icons.fastfood,
    },
    {
      'name': 'Chocolate Ice Cream',
      'category': 'Dessert',
      'price': '₹99',
      'icon': Icons.icecream,
    },
    {
      'name': 'Chocolate Cake',
      'category': 'Dessert',
      'price': '₹149',
      'icon': Icons.cake,
    },
  ];

  List<Map<String, dynamic>> get filteredFoods {
    return foods.where((food) {
      final categoryMatch =
          selectedCategory == 'All' ||
          food['category'] == selectedCategory;

      final searchMatch = food['name']
          .toString()
          .toLowerCase()
          .contains(searchText.toLowerCase());

      return categoryMatch && searchMatch;
    }).toList();
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
      searchText = '';
      searchController.clear();
    });
  }

  void addToCart(String foodName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$foodName added to cart'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: const Text(
          'FoodoraX',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // My Orders
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrdersPage(),
                ),
              );
            },
            icon: const Icon(Icons.receipt_long),
            tooltip: 'My Orders',
          ),

          // Cart
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Cart',
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delicious food,',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Text(
              'delivered to your door!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.deepOrange,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            // Search
            TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                  selectedCategory = 'All';
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for food...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchText.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            searchText = '';
                            searchController.clear();
                          });
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 105,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  category(Icons.apps, 'All'),
                  category(Icons.local_pizza, 'Pizza'),
                  category(Icons.lunch_dining, 'Burger'),
                  category(Icons.rice_bowl, 'Biryani'),
                  category(Icons.fastfood, 'Fries'),
                  category(Icons.icecream, 'Dessert'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              selectedCategory == 'All'
                  ? 'Popular Food'
                  : '$selectedCategory Items',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // Food Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredFoods.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final food = filteredFoods[index];

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.shade50,
                              borderRadius:
                                  BorderRadius.circular(15),
                            ),
                            child: Icon(
                              food['icon'],
                              size: 65,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          food['name'],
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          food['price'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              addToCart(food['name']);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Add'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // No search results
            if (filteredFoods.isEmpty)
              const Padding(
                padding: EdgeInsets.all(30),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 60,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'No food found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget category(IconData icon, String name) {
    final isSelected = selectedCategory == name;

    return GestureDetector(
      onTap: () => selectCategory(name),
      child: Container(
        width: 85,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.deepOrange
                    : Colors.deepOrange.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? Colors.white
                    : Colors.deepOrange,
              ),
            ),

            const SizedBox(height: 7),

            Text(
              name,
              style: TextStyle(
                fontWeight: isSelected
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}