import 'package:e_commerce_app/Routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:e_commerce_app/Screens/categories_screen.dart';

class banner extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Color(0xFF2F6BFF), Color(0xFF2F6BFF).withValues(alpha: 0.2)],
        ),
      ),
      width: double.infinity,
      height: 200,
      child: Stack(
        children: [
          Column(
            //crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 14),
              Text(
                'Upgrade \nYour Style',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  'Premium Quality, Better Style',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  backgroundColor: Color(0xFF0A1020),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.showallproduct);
                },
                child: Text(
                  'Shop Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: -30,
            bottom: -20,
            left: 135,
            top: 0,

            child: Lottie.asset(
              'assets/Images/banner_shoes.json',
              repeat: false,
              height: 110,
              width: 150,
            ),
          ),
        ],
      ),
    );
  }
}
