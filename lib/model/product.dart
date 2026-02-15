import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String price;
  final String image;
  final Color backgroundColor;
  final bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.backgroundColor = Colors.white,
    this.isFavorite = false,
  });

  // Added copyWith to handle state updates
  Product copyWith({bool? isFavorite}) {
    return Product(
      id: id,
      name: name,
      price: price,
      image: image,
      backgroundColor: backgroundColor,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

List<Product> recommendedProducts = [
  Product(
    id: '1',
    name: 'Honey lime combo',
    price: '2,000',
    image: 'assets/Honey-Lime-Peach-Fruit-Salad-3-725x725.png',
  ),
  Product(
    id: '2',
    name: 'Berry mango combo',
    price: '8,000',
    image: 'assets/Glowing-Berry-Fruit-Salad-8-720x720.png',
  ),
];

List<Product> filteredProducts = [
  Product(
    id: '3',
    name: 'Quinoa fruit salad',
    price: '10,000',
    image: 'assets/breakfast-quinoa-and-red-fruit-salad-134061-1.png',
    backgroundColor: const Color(0xFFFFFAEB),
  ),
  Product(
    id: '4',
    name: 'Tropical fruit salad',
    price: '10,000',
    image: 'assets/Best-Ever-Tropical-Fruit-Salad8-WIDE-removebg-preview 1.png',
    backgroundColor: const Color(0xFFFEF3EF),
  ),
  Product(
    id: '5',
    name: 'Melon fruit salad',
    price: '10,000',
    image: 'assets/BerryWorld-Kiwiberry-Fruit-Salad-LS-removebg-preview 1.png',
    backgroundColor: const Color(0xFFF1EFFE),
  ),
];