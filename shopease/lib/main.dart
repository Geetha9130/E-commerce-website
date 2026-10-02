import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/product.dart';
import 'providers/cart_provider.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';

void main() {
  runApp(const ShopEaseApp());
}

class ShopEaseApp extends StatelessWidget {
  const ShopEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp(
        title: 'ShopEase',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme, // EXPERIMENT 6(b)
        initialRoute: '/',
        // EXPERIMENT 4: Named routes
        routes: {
          '/': (context) => const HomeScreen(),
          '/cart': (context) => const CartScreen(),
          '/checkout': (context) => const CheckoutScreen(),
        },
        // Route that needs an argument (the tapped product)
        onGenerateRoute: (settings) {
          if (settings.name == '/detail') {
            final product = settings.arguments as Product;
            return MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            );
          }
          return null;
        },
      ),
    );
  }
}
