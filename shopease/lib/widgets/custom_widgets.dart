import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// EXPERIMENT 6(a): Custom widget - reusable primary button.
class CustomButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  // EXPERIMENT 8: scale "bounce" animation on tap.
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    lowerBound: 0,
    upperBound: 0.07,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) =>
          Transform.scale(scale: 1 - _controller.value, child: child),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () async {
            await _controller.forward();
            await _controller.reverse();
            widget.onPressed();
          },
          icon: widget.icon != null ? Icon(widget.icon) : const SizedBox.shrink(),
          label: Text(widget.label),
        ),
      ),
    );
  }
}

// EXPERIMENT 6(a): Custom widget - styled text field.
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final String? Function(String?) validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppTheme.primary),
      ),
    );
  }
}

// EXPERIMENT 6(a) + 2: Custom widget combining Stack, Column for a product card.
class ProductCardBadge extends StatelessWidget {
  final String text;
  const ProductCardBadge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}
