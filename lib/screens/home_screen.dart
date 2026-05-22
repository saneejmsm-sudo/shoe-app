import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shoe_provider.dart';
import '../providers/navigation_provider.dart';
import '../utils/app_data.dart';
import '../widgets/shoe_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shoeProvider = Provider.of<ShoeProvider>(context);
    final navigationProvider = Provider.of<NavigationProvider>(context, listen: false);
    final shoes = shoeProvider.shoes;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/app_logo.jpg',
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704d'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Find Your Style',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 25),
                // Search Bar - taps to navigate to Explore tab
                GestureDetector(
                  onTap: () {
                    navigationProvider.setIndex(1); // Index 1 is Explore
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey),
                        const SizedBox(width: 10),
                        Text('Search shoes...', style: TextStyle(color: Colors.grey[400])),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                // New Arrival Promo Banner
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/new_arrival_banner.jpg',
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 25),
                // Categories section with (All, Running, Casual, Formal, Sport)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Categories', style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: AppData.categories.length + 1,
                    itemBuilder: (context, index) {
                      final isAll = index == 0;
                      final categoryName = isAll ? 'All' : AppData.categories[index - 1].name;
                      final isSelected = shoeProvider.selectedCategory == categoryName;

                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: FilterChip(
                          label: Text(categoryName),
                          selected: isSelected,
                          onSelected: (bool selected) {
                            shoeProvider.setCategory(categoryName);
                          },
                          selectedColor: Theme.of(context).primaryColor,
                          checkmarkColor: Colors.white,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 25),
                // Product Grid (2-column product grid with product cards)
                Text('Products', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 15),
                shoes.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.0),
                          child: Text('No products found in this category.'),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.70,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemCount: shoes.length,
                        itemBuilder: (context, index) {
                          return ShoeCard(shoe: shoes[index]);
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

