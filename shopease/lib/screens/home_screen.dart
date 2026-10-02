import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';

// EXPERIMENT 3: Responsive UI - grid column count adapts to screen width.
// EXPERIMENT 4: Navigation using named routes.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final width = MediaQuery.of(context).size.width;

    // Responsive breakpoints
    int crossAxisCount;
    if (width < 500) {
      crossAxisCount = 2;
    } else if (width < 900) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 4;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopEase'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              ),
              if (cart.itemCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cart.itemCount}',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: sampleProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        itemBuilder: (context, index) {
          final product = sampleProducts[index];
          return ProductCard(
            product: product,
            onTap: () => Navigator.pushNamed(
              context,
              '/detail',
              arguments: product,
            ),
          );
        },
      ),
    );
  }
}
