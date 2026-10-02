import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/custom_widgets.dart';

// EXPERIMENT 7: Form with multiple input fields + validation and error handling.
// EXPERIMENT 8: Fade/scale animation on successful order placement.
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cardController = TextEditingController();

  bool _placingOrder = false;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _placingOrder = true);
    await Future.delayed(const Duration(seconds: 1)); // simulate processing

    if (!mounted) return;
    context.read<CartProvider>().clearCart();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 400),
          curve: Curves.elasticOut,
          builder: (context, value, child) =>
              Transform.scale(scale: value, child: child),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 12),
              Text('Order placed successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text('Back to Shop'),
          ),
        ],
      ),
    );

    setState(() => _placingOrder = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.person_outline,
                validator: (value) => (value == null || value.trim().length < 3)
                    ? 'Enter your full name'
                    : null,
              ),
              const SizedBox(height: 14),
              CustomTextField(
                controller: _addressController,
                label: 'Shipping Address',
                icon: Icons.home_outlined,
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Address is required'
                    : null,
              ),
              const SizedBox(height: 14),
              CustomTextField(
                controller: _phoneController,
                label: 'Phone Number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  final digits = value?.replaceAll(RegExp(r'\D'), '') ?? '';
                  if (digits.length != 10) return 'Enter a valid 10-digit phone number';
                  return null;
                },
              ),
              const SizedBox(height: 14),
              CustomTextField(
                controller: _cardController,
                label: 'Card Number',
                icon: Icons.credit_card,
                keyboardType: TextInputType.number,
                validator: (value) {
                  final digits = value?.replaceAll(RegExp(r'\D'), '') ?? '';
                  if (digits.length != 16) return 'Card number must be 16 digits';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              _placingOrder
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      label: 'Place Order',
                      icon: Icons.lock_outline,
                      onPressed: _placeOrder,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
