// EXPERIMENT 1: Basic Dart class, constructors, fields, methods.
class Product {
  final String id;
  final String name;
  final double price;
  final String emoji; // used instead of network images for simplicity
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.emoji,
    required this.description,
  });

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
}

// A small static "database" of products.
final List<Product> sampleProducts = [
  const Product(
    id: 'p1',
    name: 'Wireless Headphones',
    price: 59.99,
    emoji: '🎧',
    description:
        'Over-ear wireless headphones with noise cancellation and 20-hour battery life.',
  ),
  const Product(
    id: 'p2',
    name: 'Smart Watch',
    price: 89.50,
    emoji: '⌚',
    description:
        'Fitness tracking smart watch with heart-rate monitor and sleep tracking.',
  ),
  const Product(
    id: 'p3',
    name: 'Backpack',
    price: 34.00,
    emoji: '🎒',
    description: 'Water-resistant backpack with padded laptop compartment.',
  ),
  const Product(
    id: 'p4',
    name: 'Sunglasses',
    price: 21.75,
    emoji: '🕶️',
    description: 'UV-protected polarized sunglasses with a lightweight frame.',
  ),
  const Product(
    id: 'p5',
    name: 'Coffee Mug',
    price: 12.00,
    emoji: '☕',
    description: 'Ceramic mug that keeps your coffee warm for longer.',
  ),
  const Product(
    id: 'p6',
    name: 'Desk Lamp',
    price: 27.30,
    emoji: '💡',
    description: 'Adjustable LED desk lamp with 3 brightness levels.',
  ),
];
