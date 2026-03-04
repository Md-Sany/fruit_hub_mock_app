import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String price;
  final String image;
  final String description;
  final Color? backgroundColor; // Nullable for "no background" items
  final bool isFavorite;
  final DateTime addedDate;       // Track when product was added
  final int favoriteCount;        // Count of users who favorited
  final int totalSells;           // Total lifetime sales
  final int sellsLast24Hours;     // Sales in the last 24 hours for "Hottest"

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    this.backgroundColor,
    this.isFavorite = false,
    required this.addedDate,
    this.favoriteCount = 0,
    this.totalSells = 0,
    this.sellsLast24Hours = 0,
  });

  Product copyWith({bool? isFavorite, String? description}) {
    return Product(
      id: id,
      name: name,
      price: price,
      image: image,
      description: description ?? this.description,
      backgroundColor: backgroundColor,
      isFavorite: isFavorite ?? this.isFavorite,
      addedDate: addedDate,
      favoriteCount: favoriteCount,
      totalSells: totalSells,
      sellsLast24Hours: sellsLast24Hours,
    );
  }
}

// 1. All items in one product model list
List<Product> allProducts = [
  Product(
    id: '1',
    name: 'Honey lime combo',
    price: '2,000',
    image: 'assets/Honey-Lime-Peach-Fruit-Salad-3-725x725.png',
    description: "Honey, Lime, Peach, Grapes, and fresh Mint leaves.",
    addedDate: DateTime.now().subtract(const Duration(days: 5)),
    favoriteCount: 150,
    totalSells: 300,
    sellsLast24Hours: 15,
  ),
  Product(
    id: '2',
    name: 'Berry mango combo',
    price: '8,000',
    image: 'assets/Glowing-Berry-Fruit-Salad-8-720x720.png',
    description: "Blueberries, Blackberries, Mango chunks, and Raspberry syrup.",
    addedDate: DateTime.now().subtract(const Duration(days: 2)),
    favoriteCount: 85,
    totalSells: 120,
    sellsLast24Hours: 50,
  ),
  Product(
    id: '3',
    name: 'Quinoa fruit salad',
    price: '10,000',
    image: 'assets/breakfast-quinoa-and-red-fruit-salad-134061-1.png',
    backgroundColor: const Color(0xFFFFFAEB),
    description: "Red Quinoa, Lime, Honey, Blueberries, Strawberries, Mango, Fresh mint.",
    addedDate: DateTime.now(),
    favoriteCount: 45,
    totalSells: 200,
    sellsLast24Hours: 10,
  ),
  Product(
    id: '4',
    name: 'Tropical fruit salad',
    price: '10,000',
    image: 'assets/Best-Ever-Tropical-Fruit-Salad8-WIDE-removebg-preview 1.png',
    backgroundColor: const Color(0xFFFEF3EF),
    description: "Pineapple, Papaya, Watermelon, and Coconut flakes.",
    addedDate: DateTime.now(),
    favoriteCount: 60,
    totalSells: 500,
    sellsLast24Hours: 40,
  ),
  Product(
    id: '5',
    name: 'Melon fruit salad',
    price: '10,000',
    image: 'assets/BerryWorld-Kiwiberry-Fruit-Salad-LS-removebg-preview 1.png',
    backgroundColor: const Color(0xFFF1EFFE),
    description: "Honeydew, Cantaloupe, Watermelon, and Lime zest.",
    addedDate: DateTime.now(),
    favoriteCount: 30,
    totalSells: 90,
    sellsLast24Hours: 5,
  ),

  // 5. Generate 20 more items (duplicates with different names/long descriptions)
  ...List.generate(20, (index) {
    return Product(
      id: 'extra_${index + 10}',
      name: 'Special Variant ${index + 1}',
      price: '${(index + 1) * 1200}',
      image: index % 2 == 0
          ? 'assets/breakfast-quinoa-and-red-fruit-salad-134061-1.png'
          : 'assets/Best-Ever-Tropical-Fruit-Salad8-WIDE-removebg-preview 1.png',
      // Long description variation
      description: "This special variant ${index + 1} offers a unique twist on our classic recipes. "
          "Carefully curated by our master chefs, this fruit salad features premium seasonal ingredients "
          "balanced for both flavor and maximum nutritional benefit. Experience the fresh textures and "
          "vibrant aromas in every bite of this handcrafted healthy meal option.",
      addedDate: DateTime.now().subtract(Duration(hours: index * 4)),
      favoriteCount: (index + 1) * 7,
      totalSells: (index + 1) * 15,
      sellsLast24Hours: index + 2,
      // No background color for these extra items
      backgroundColor: null,
    );
  }),
];

// Compatibility lists for your current ProductController structure
List<Product> recommendedProducts = allProducts.where((p) => p.totalSells > 200).toList();
List<Product> filteredProducts = allProducts;