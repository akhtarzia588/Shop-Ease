import 'package:e_commerce_app/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/Screens/Sign_in.dart';
import 'package:e_commerce_app/Screens/signup.dart';
import 'package:e_commerce_app/Screens/splash.dart';
import 'package:e_commerce_app/Screens/welcome.dart';

class AppRoutes {
  static const String splash = '/';
  static const String signup = '/signup';
  static const String signin = '/signin';
  static const String welcome = '/welcome';
  static const String homescreen = '/home';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => Splash(),
    signup: (context) => Signup(),
    signin: (context) => LoginScreen(),
    welcome: (context) => Welcome(),
    homescreen: (context) => HomeScreen(),
  };
}
