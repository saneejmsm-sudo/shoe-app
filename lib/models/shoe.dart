class Shoe {
  final String id;
  final String brand;
  final String name;
  final double price;
  final double rating;
  final int reviews;
  final String category;
  final String description;

  const Shoe({
    required this.id,
    required this.brand,
    required this.name,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.category,
    required this.description,
  });
}

const List<Shoe> shoeList = [
  Shoe(
    id: '1',
    brand: 'Nike',
    name: 'Air Force 1',
    price: 129.00,
    rating: 4.9,
    reviews: 2341,
    category: 'Casual',
    description:
        'The Nike Air Force 1 is a classic sneaker loved worldwide. Featuring a clean leather upper and iconic Air cushioning, it pairs perfectly with any outfit.',
  ),
  Shoe(
    id: '2',
    brand: 'Adidas',
    name: 'Ultraboost 24',
    price: 189.00,
    rating: 4.7,
    reviews: 1823,
    category: 'Running',
    description:
        'Engineered for runners who want maximum energy return. The Ultraboost 24 features a Primeknit upper and responsive Boost midsole for an energized ride.',
  ),
  Shoe(
    id: '3',
    brand: 'Puma',
    name: 'RS-X Retro',
    price: 99.00,
    rating: 4.5,
    reviews: 943,
    category: 'Casual',
    description:
        'Bold retro style meets modern comfort. The RS-X brings chunky sole design with running system technology in a lifestyle shoe.',
  ),
  Shoe(
    id: '4',
    brand: 'New Balance',
    name: '990v6',
    price: 214.00,
    rating: 5.0,
    reviews: 562,
    category: 'Running',
    description:
        'Made in the USA. The 990v6 delivers premium comfort with a ENCAP midsole and pigskin/mesh upper. A timeless runner for everyday use.',
  ),
  Shoe(
    id: '5',
    brand: 'Nike',
    name: 'Air Max 270',
    price: 150.00,
    rating: 4.6,
    reviews: 3102,
    category: 'Casual',
    description:
        'The Nike Air Max 270 features the tallest Air unit yet, delivering plush, all-day comfort. The breathable mesh upper keeps you cool and stylish.',
  ),
  Shoe(
    id: '6',
    brand: 'Adidas',
    name: 'Stan Smith',
    price: 89.00,
    rating: 4.8,
    reviews: 5221,
    category: 'Casual',
    description:
        'A true icon. The Stan Smith has been a staple sneaker since the 1970s. Clean, minimal, and versatile, it goes with everything.',
  ),
];
