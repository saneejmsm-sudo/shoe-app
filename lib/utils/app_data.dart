import '../models/models.dart';

class AppData {
  static List<Category> categories = [
    Category(id: '1', name: 'Running', icon: '🏃'),
    Category(id: '2', name: 'Casual', icon: '🚶'),
    Category(id: '3', name: 'Formal', icon: '👔'),
    Category(id: '4', name: 'Sport', icon: '👟'),
  ];

  static List<Shoe> shoes = [
    Shoe(
      id: '1',
      name: 'Air Max 270',
      brand: 'Nike',
      description: 'The Nike Air Max 270 delivers visible cushioning under every step. Updated for modern comfort, it nods to the original 1991 Air Max 180 with its exaggerated tongue top and heritage tongue logo.',
      price: 150.0,
      imagePath: 'assets/images/nike_air_max_270.png',
      availableSizes: ['40', '41', '42', '43', '44'],
      rating: 4.8,
      reviewsCount: 120,
      category: 'Sport',
    ),
    Shoe(
      id: '2',
      name: 'Ultraboost 22',
      brand: 'Adidas',
      description: 'A little extra push. The Ultraboost running shoes serve up comfort and responsiveness at every pace and distance. The Linear Energy Push system increases forefoot and midfoot stiffness for an extra energy push in every step.',
      price: 180.0,
      imagePath: 'assets/images/adidas_ultraboost_22.png',
      availableSizes: ['39', '40', '41', '42', '43'],
      rating: 4.9,
      reviewsCount: 85,
      category: 'Running',
    ),
    Shoe(
      id: '3',
      name: 'Classic Leather',
      brand: 'Reebok',
      description: 'You don\'t need a lot of bells and whistles to make a statement. These Reebok Classic Leather shoes prove it. Their clean, minimalist design keeps your look sharp and sophisticated.',
      price: 85.0,
      imagePath: 'assets/images/reebok_classic_leather.png',
      availableSizes: ['40', '41', '42', '43', '44', '45'],
      rating: 4.5,
      reviewsCount: 210,
      category: 'Casual',
    ),
    Shoe(
      id: '4',
      name: 'Oxford Brogue',
      brand: 'Clarks',
      description: 'Elevate your formal attire with these timeless Oxford Brogues. Crafted from premium leather with intricate perforated details, they offer both style and durability for any occasion.',
      price: 120.0,
      imagePath: 'assets/images/clarks_oxford_brogue.png',
      availableSizes: ['41', '42', '43', '44'],
      rating: 4.7,
      reviewsCount: 45,
      category: 'Formal',
    ),
    Shoe(
      id: '5',
      name: 'React Phantom Run',
      brand: 'Nike',
      description: 'The Nike React Phantom Run Flyknit 2 offers versatility for the everyday runner. Building on its predecessor, the shoe expands on its laceless design by adding secure support that feels like it disappears on your foot.',
      price: 140.0,
      imagePath: 'assets/images/nike_air_max_270.png', // Reusing for demo
      availableSizes: ['40', '41', '42', '43'],
      rating: 4.6,
      reviewsCount: 67,
      category: 'Running',
    ),
    Shoe(
      id: '6',
      name: 'Forum Low',
      brand: 'Adidas',
      description: 'More than just a shoe, it\'s a statement. The Adidas Forum hit the scene in \'84 and gained major love on both the hardwood and in the music biz.',
      price: 100.0,
      imagePath: 'assets/images/adidas_ultraboost_22.png', // Reusing for demo
      availableSizes: ['38', '39', '40', '41', '42', '43'],
      rating: 4.8,
      reviewsCount: 156,
      category: 'Sport',
    ),
  ];
}
