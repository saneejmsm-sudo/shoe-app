import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shoe_provider.dart';
import '../utils/app_data.dart';
import '../widgets/shoe_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shoeProvider = Provider.of<ShoeProvider>(context);
    final featuredShoes = shoeProvider.featuredShoes;
    final trendingShoes = shoeProvider.trendingShoes;

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
                // Search Bar
                GestureDetector(
                  onTap: () {
                    // Navigate to explore with focus on search
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
                // New Arrival Banner
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
                // Categories
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Categories', style: Theme.of(context).textTheme.titleLarge),
                    TextButton(
                      onPressed: () {},
                      child: const Text('See All'),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: AppData.categories.length,
                    itemBuilder: (context, index) {
                      final category = AppData.categories[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Text(category.icon, style: const TextStyle(fontSize: 24)),
                            ),
                            const SizedBox(height: 8),
                            Text(category.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                // Featured
                Text('Featured Shoes', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 15),
                SizedBox(
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: featuredShoes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ShoeCard(shoe: featuredShoes[index], isHorizontal: true),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                // Trending
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Trending', style: Theme.of(context).textTheme.titleLarge),
                    TextButton(
                      onPressed: () {},
                      child: const Text('View All'),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: trendingShoes.length,
                  itemBuilder: (context, index) {
                    return ShoeCard(shoe: trendingShoes[index]);
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
