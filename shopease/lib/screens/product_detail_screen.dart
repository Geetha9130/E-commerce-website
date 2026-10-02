import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/custom_widgets.dart';

// EXPERIMENT 5(a): StatefulWidget using setState for local UI state (quantity).
// EXPERIMENT 8: Hero continuation + fade-in animation for description.
class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  int _quantity = 1; // local state managed with setState

  late final AnimationController _fadeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  )..forward();
  late final Animation<double> _fade =
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _increment() => setState(() => _quantity++);
  void _decrement() => setState(() {
        if (_quantity > 1) _quantity--;
      });

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFFE7F1EC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Hero(
                  tag: product.id,
                  child: Text(product.emoji, style: const TextStyle(fontSize: 90)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _fade,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style:
                          const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(product.formattedPrice,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF2E7D5B),
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 14),
                  Text(product.description,
                      style: const TextStyle(fontSize: 15, color: Colors.black87)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _decrement,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('$_quantity', style: const TextStyle(fontSize: 18)),
                IconButton(
                  onPressed: _increment,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const SizedBox(height: 10),
            CustomButton(
              label: 'Add to Cart',
              icon: Icons.shopping_cart_outlined,
              onPressed: () {
                final cart = context.read<CartProvider>();
                for (int i = 0; i < _quantity; i++) {
                  cart.addToCart(product);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.name} added to cart')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
