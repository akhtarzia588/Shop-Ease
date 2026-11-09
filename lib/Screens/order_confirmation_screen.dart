import 'package:e_commerce_app/Routes/app_routes.dart';
import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String orderId;
  final double total;

  const OrderConfirmationScreen({
    super.key,
    required this.orderId,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final orderNumber = orderId.substring(0, 6).toUpperCase();

    return PopScope(
      canPop: false, // back dabane se checkout par wapas nahi jana
      child: Scaffold(
        backgroundColor: const Color(0xFF0A1020),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF22C55E),
                  size: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Order placed!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Order #$orderNumber',
                  style: const TextStyle(
                    color: Color(0xFF2F6BFF),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Total: \$${total.toStringAsFixed(2)}  •  Cash on Delivery',
                  style: const TextStyle(color: Colors.white60),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F6BFF),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.Navbar,
                      (route) => false,
                    ),
                    child: const Text(
                      'Continue shopping',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
