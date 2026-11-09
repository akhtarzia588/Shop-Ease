import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_app/Providers/cart_provider.dart';
import 'package:e_commerce_app/Services/location_service.dart';
import 'package:e_commerce_app/Screens/order_confirmation_screen.dart';

class CheckoutScreen1 extends StatefulWidget {
  const CheckoutScreen1({super.key});

  @override
  State<CheckoutScreen1> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen1> {
  final _address = TextEditingController();
  final _phone = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fillAddress();
  }

  @override
  void dispose() {
    _address.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _fillAddress() async {
    final r = await LocationService().getCurrentLocation();
    if (!mounted) return;
    if (r.status == LocationStatus.success && _address.text.isEmpty) {
      _address.text = '${r.address ?? ''}, ';
    }
  }

  void _toast(String msg, Color color) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: color,
      textColor: Colors.white,
    );
  }

  Future<void> _placeOrder() async {
    final address = _address.text.trim();
    final phone = _phone.text.trim();

    if (address.length < 10) {
      _toast(
        'Please enter your full delivery address',
        const Color(0xFFF59E0B),
      );
      return;
    }
    if (phone.length < 10) {
      _toast('Please enter a valid phone number', const Color(0xFFF59E0B));
      return;
    }

    final cart = context.read<CartProvider>();
    final total = cart.grandtotal;
    setState(() => _loading = true);
    try {
      final orderId = await cart.placeOrder(
        address: address,
        phone: phone,
        paymentmethod: 'cod',
      );

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              OrderConfirmationScreen(orderId: orderId, total: total),
        ),
      );
    } on FirebaseException catch (e) {
      if (e.code == 'network-request-failed' || e.code == 'unavailable') {
        _toast('No internet connection', const Color(0xFF64748B));
      } else {
        _toast(
          'Could not place order. Please try again',
          const Color(0xFFEF4444),
        );
      }
    } catch (e) {
      _toast('Something went wrong. Please try again', const Color(0xFFEF4444));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  InputDecoration _decoration(String label, IconData icon) => InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: Colors.white70),
    prefixIcon: Icon(icon, color: Colors.white70),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.white38),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF2F6BFF), width: 2),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF0A1020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A1020),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Checkout', style: TextStyle(color: Colors.white)),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Delivery address',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _address,
            maxLines: 2,
            style: const TextStyle(color: Colors.white),
            decoration: _decoration(
              'House no, street, area, city',
              Icons.location_on,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            style: const TextStyle(color: Colors.white),
            decoration: _decoration('Phone number', Icons.phone),
          ),

          const SizedBox(height: 24),
          const Text(
            'Payment method',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF111A36),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2F6BFF)),
            ),
            child: const Row(
              children: [
                Icon(Icons.payments_outlined, color: Colors.white),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Cash on Delivery',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Icon(Icons.check_circle, color: Color(0xFF2F6BFF)),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const Text(
            'Order summary',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...cart.items.map(
            (i) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${i.name}  x${i.quantity}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                  Text(
                    '\$${(i.price * i.quantity).toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.white24, height: 24),
          _row('Subtotal', cart.total),
          _row('Delivery fee', CartProvider.deliveryfees),
        ],
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFF111A36),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  Text(
                    '\$${cart.grandtotal.toStringAsFixed(1)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F6BFF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: (_loading || cart.items.isEmpty)
                      ? null
                      : _placeOrder,
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Place Order',
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
    );
  }

  Widget _row(String label, double value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: const TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}
