import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/navigation_provider.dart';
import '../utils/currency_utils.dart';

class DetailsScreen extends StatefulWidget {
  final Shoe shoe;

  const DetailsScreen({super.key, required this.shoe});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String? _selectedSize;

  @override
  void initState() {
    super.initState();
    if (widget.shoe.availableSizes.isNotEmpty) {
      _selectedSize = widget.shoe.availableSizes[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFavorite = favoritesProvider.isFavorite(widget.shoe.id);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              favoritesProvider.toggleFavorite(widget.shoe.id);
            },
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              height: 400,
              width: double.infinity,
              child: widget.shoe.imagePath.startsWith('http')
                  ? Image.network(widget.shoe.imagePath, fit: BoxFit.cover)
                  : Image.asset(widget.shoe.imagePath, fit: BoxFit.cover),
            ),
            // Content Section
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.shoe.brand,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.shoe.rating} (${widget.shoe.reviewsCount} reviews)',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.shoe.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    CurrencyUtils.format(widget.shoe.price),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Select Size',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.shoe.availableSizes.length,
                      itemBuilder: (context, index) {
                        final size = widget.shoe.availableSizes[index];
                        final isSelected = _selectedSize == size;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSize = size;
                            });
                          },
                          child: Container(
                            width: 60,
                            margin: const EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              color: isSelected ? Theme.of(context).primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              size,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.shoe.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 100), // Space for bottom bar
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedSize != null) {
                    cartProvider.addItem(widget.shoe, _selectedSize!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${widget.shoe.name} added to cart!'),
                        duration: const Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'VIEW CART',
                          onPressed: () {
                            Provider.of<NavigationProvider>(context, listen: false).setIndex(2);
                            Navigator.of(context).pop(); // Go back to main layout which is now on Cart tab
                          },
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
