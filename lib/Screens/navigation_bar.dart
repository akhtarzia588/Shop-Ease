import 'package:e_commerce_app/Providers/cart_provider.dart';
import 'package:e_commerce_app/Screens/cart_screen.dart';
import 'package:e_commerce_app/Screens/categories_screen.dart';
import 'package:e_commerce_app/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class NavigationBar1 extends StatefulWidget {
  const NavigationBar1({super.key});

  @override
  State<NavigationBar1> createState() => _NavigationBar1State();
}

class _NavigationBar1State extends State<NavigationBar1> {
  int selectedindex = 0;
  late final List<Widget> page;

  @override
  void initState() {
    page = [
      HomeScreen(),
      CategoriesScreen(),
      CartScreen1(),

      const Center(
        child: Text('Wishlist Screen', style: TextStyle(color: Colors.white)),
      ),
      const Center(
        child: Text('Profile Screen', style: TextStyle(color: Colors.white)),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedindex,
        elevation: 2,
        type: BottomNavigationBarType.fixed,
        iconSize: 23,
        selectedItemColor: const Color(0xFF2F6BFF),
        unselectedItemColor: Colors.white,
        selectedFontSize: 12,
        unselectedFontSize: 8,
        backgroundColor: const Color(0xFF0A1020).withValues(alpha: 0.84),
        selectedLabelStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(color: Colors.white60, fontSize: 12),

        onTap: (value) {
          setState(() {
            selectedindex = value;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(selectedindex == 0 ? Iconsax.home_11 : Iconsax.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedindex == 1 ? Iconsax.category5 : Iconsax.category_2,
            ),
            label: 'Category',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              selectedindex == 2
                  ? Iconsax.shopping_cart5
                  : Iconsax.shopping_cart,
              size: 36,
            ),
            label: 'Cart',
          ),

          BottomNavigationBarItem(
            icon: Icon(selectedindex == 3 ? Iconsax.heart5 : Iconsax.heart),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedindex == 4 ? Iconsax.user : Iconsax.user),
            label: 'Profile',
          ),
        ],
      ),
      body: page[selectedindex],
    );
  }
}
