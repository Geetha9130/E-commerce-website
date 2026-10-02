import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/custom_widgets.dart';

// EXPERIMENT 5(b): Reading/mutating shared Provider state from another screen.
// EXPERIMENT 8: AnimatedSize / implicit animation when items are removed.
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: items.isEmpty
          ? const Center(child: Text('Your cart is empty 🛒'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(14),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: Text(item.product.emoji,
                                style: const TextStyle(fontSize: 32)),
                            title: Text(item.product.name),
                            subtitle: Text(
                                '${item.product.formattedPrice} x ${item.quantity}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () => context
                                      .read<CartProvider>()
                                      .decrementQuantity(item.product.id),
                                ),
                                Text('${item.quantity}'),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => context
                                      .read<CartProvider>()
                                      .incrementQuantity(item.product.id),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total', style: TextStyle(fontSize: 18)),
                          Text('\$${cart.totalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      CustomButton(
                        label: 'Checkout',
                        icon: Icons.arrow_forward,
                        onPressed: () => Navigator.pushNamed(context, '/checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
