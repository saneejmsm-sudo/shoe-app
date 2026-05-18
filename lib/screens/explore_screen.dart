import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shoe_provider.dart';
import '../utils/app_data.dart';
import '../widgets/shoe_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shoeProvider = Provider.of<ShoeProvider>(context);
    final shoes = shoeProvider.shoes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Shoes'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              onChanged: (value) => shoeProvider.setSearchQuery(value),
              decoration: InputDecoration(
                hintText: 'Search brand or model...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
          // Categories Filter
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AppData.categories.length + 1,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemBuilder: (context, index) {
                final isAll = index == 0;
                final categoryName = isAll ? 'All' : AppData.categories[index - 1].name;
                final isSelected = shoeProvider.selectedCategory == categoryName;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
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
          const SizedBox(height: 10),
          // Results Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${shoes.length} Results Found',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Grid
          Expanded(
            child: shoes.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 80, color: Colors.grey),
                        SizedBox(height: 20),
                        Text('No shoes found matching your search.', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: shoes.length,
                    itemBuilder: (context, index) {
                      return ShoeCard(shoe: shoes[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
