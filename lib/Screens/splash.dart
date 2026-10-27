import 'dart:async';

import 'package:e_commerce_app/Routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/Constraints/Constraints.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const new({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.signup);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: Design.gradient),

        child: Stack(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/Images/logo_animation.json',
                    repeat: false,
                    height: 260,
                    // width: double.infinity,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Shop',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Ease',
                        style: TextStyle(
                          color: const Color(0xFF2F6BFF),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Better Products Happier You',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 210,
              bottom: -230,
              left: -50,
              right: -80,

              child: Image.asset(
                'assets/Images/splash.png',
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
