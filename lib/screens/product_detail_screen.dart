import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/shoe.dart';
import '../models/app_theme.dart';
import '../models/cart_provider.dart';
import '../widgets/app_button.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Shoe shoe;

  const ProductDetailScreen({super.key, required this.shoe});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final List<int> _sizes = [39, 40, 41, 42, 43, 44];
  int _selectedSize = -1;
  bool _liked = false;

  void _addToCart() {
    if (_selectedSize == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a size first.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }
    context.read<CartProvider>().addToCart(widget.shoe, _selectedSize);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.shoe.name} added to cart!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: SnackBarAction(
          label: 'View Cart',
          textColor: kWhite,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CartScreen()),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Back + like
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: kLightGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back_rounded,
                          size: 20, color: kBlack),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _liked = !_liked),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: kLightGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _liked
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        size: 20,
                        color: _liked ? Colors.red : kBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shoe image
                    Container(
                      width: double.infinity,
                      height: 220,
                      decoration: BoxDecoration(
                        color: kLightGrey,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Center(
                        child: Text('👟', style: TextStyle(fontSize: 100)),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Brand
                    Text(
                      widget.shoe.brand.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: kGrey,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Name + Price
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(widget.shoe.name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: kBlack,
                              )),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '\$${widget.shoe.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: kBlack,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            size: 16, color: kGold),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.shoe.rating}  •  ${widget.shoe.reviews} reviews',
                          style: const TextStyle(fontSize: 12, color: kGrey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: kLightGrey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.shoe.category,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: kBlack,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Description
                    const Text('Description', style: kTitle),
                    const SizedBox(height: 8),
                    Text(
                      widget.shoe.description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: kGrey,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Size selector
                    const Text('Select Size', style: kTitle),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _sizes.map((size) {
                        final isSelected = _selectedSize == size;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedSize = size),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: isSelected ? kBlack : kWhite,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? kBlack : kBorder,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '$size',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? kWhite : kBlack,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // Add to cart button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: AppButton(
                label: 'Add to Cart',
                onTap: _addToCart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
