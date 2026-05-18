import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/shoe_provider.dart';
import '../widgets/shoe_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final shoeProvider = Provider.of<ShoeProvider>(context);
    
    final favoriteShoes = shoeProvider.shoes
        .where((shoe) => favoritesProvider.isFavorite(shoe.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
      ),
      body: favoriteShoes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 100, color: Colors.grey[300]),
                  const SizedBox(height: 20),
                  const Text('No favorites yet', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  const SizedBox(height: 20),
                  const Text('Items you like will appear here.', style: TextStyle(color: Colors.grey)),
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
              itemCount: favoriteShoes.length,
              itemBuilder: (context, index) {
                return ShoeCard(shoe: favoriteShoes[index]);
              },
            ),
    );
  }
}
