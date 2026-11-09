import 'package:e_commerce_app/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/Screens/Sign_in.dart';
import 'package:e_commerce_app/Screens/signup.dart';
import 'package:e_commerce_app/Screens/splash.dart';
import 'package:e_commerce_app/Screens/welcome.dart';
import 'package:e_commerce_app/Screens/navigation_bar.dart';
import 'package:e_commerce_app/Screens/show_all_product.dart';
import 'package:e_commerce_app/Screens/cart_screen.dart';
import 'package:e_commerce_app/Screens/checkout_Screen.dart';

class AppRoutes {
  static const String homescreen = '/home';
  static const String signup = '/signup';
  static const String signin = '/signin';
  static const String welcome = '/welcome';
  static const String splash = '/';
  static const String Navbar = '/navbar';
  static const String showallproduct = '/showallproduct';
  static const String CartScreen = '/CartScreen';
  static const String CheckoutScreen = '/CheckoutScreen';

  static Map<String, WidgetBuilder> routes = {
    Navbar: (context) => NavigationBar1(),
    splash: (context) => Splash(),
    signup: (context) => Signup(),
    Navbar: (context) => NavigationBar1(),
    signin: (context) => LoginScreen(),
    welcome: (context) => Welcome(),
    homescreen: (context) => HomeScreen(),
    showallproduct: (context) => ShowAllProduct(),
    CartScreen: (context) => CartScreen1(),
    CheckoutScreen: (context) => CheckoutScreen1(),
  };
}
