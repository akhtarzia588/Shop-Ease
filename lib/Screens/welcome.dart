import 'package:e_commerce_app/Routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'dart:async';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.homescreen,
        (route) => false,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1020),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Lottie.asset(
          'assets/Images/shop_door_welcome.json',
          repeat: false,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
