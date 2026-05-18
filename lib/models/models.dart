class Shoe {
  final String id;
  final String name;
  final String brand;
  final String description;
  final double price;
  final String imagePath;
  final List<String> availableSizes;
  final double rating;
  final int reviewsCount;
  final String category;

  Shoe({
    required this.id,
    required this.name,
    required this.brand,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.availableSizes,
    required this.rating,
    required this.reviewsCount,
    required this.category,
  });

  factory Shoe.fromMap(Map<String, dynamic> map, String id) {
    return Shoe(
      id: id,
      name: map['name'] ?? '',
      brand: map['brand'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      imagePath: map['imagePath'] ?? '',
      availableSizes: List<String>.from(map['availableSizes'] ?? []),
      rating: (map['rating'] ?? 0.0).toDouble(),
      reviewsCount: map['reviewsCount'] ?? 0,
      category: map['category'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'brand': brand,
      'description': description,
      'price': price,
      'imagePath': imagePath,
      'availableSizes': availableSizes,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'category': category,
    };
  }
}

class Category {
  final String id;
  final String name;
  final String icon;

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });
}

class OrderItem {
  final Shoe shoe;
  final int quantity;
  final String size;

  OrderItem({
    required this.shoe,
    required this.quantity,
    required this.size,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      shoe: Shoe.fromMap(map['shoe'] ?? {}, map['shoe']['id'] ?? ''),
      quantity: map['quantity'] ?? 0,
      size: map['size'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shoe': shoe.toMap()..['id'] = shoe.id,
      'quantity': quantity,
      'size': size,
    };
  }
}

class Order {
  final String id;
  final List<OrderItem> items;
  final double totalAmount;
  final DateTime date;
  final String status;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.date,
    this.status = 'Pending',
  });

  factory Order.fromMap(Map<String, dynamic> map, String id) {
    return Order(
      id: id,
      items: (map['items'] as List<dynamic>?)?.map((item) => OrderItem.fromMap(item)).toList() ?? [],
      totalAmount: (map['totalAmount'] ?? 0.0).toDouble(),
      date: map['date'] != null ? DateTime.parse(map['date']) : DateTime.now(),
      status: map['status'] ?? 'Pending',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'date': date.toIso8601String(),
      'status': status,
    };
  }
}

