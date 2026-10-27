import 'package:e_commerce_app/Routes/app_routes.dart';
import 'package:e_commerce_app/Services/google_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/widget/signup_widgest/button_widget.dart';
import 'package:e_commerce_app/widget/signup_widgest/signup_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController passwordcontroller2 = TextEditingController();
  final TextEditingController emailcontroller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    login() async {
      if (passwordcontroller2 != null) {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                email: emailcontroller2.text,
                password: passwordcontroller2.text,
              );
          Fluttertoast.showToast(
            msg: "Welcome in",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color(0xFF22C55E),
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.pushNamed(context, AppRoutes.welcome);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'network-request-failed') {
            Fluttertoast.showToast(
              msg: "No internet connection",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color(0xFFF59E0B),
              textColor: Colors.white,
              fontSize: 16.0,
            );
          } else if (e.code == 'too-many-requests') {
            Fluttertoast.showToast(
              msg: "Too many attempts. Please try again later",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color(0xFFF59E0B),
              textColor: Colors.white,
              fontSize: 16.0,
            );
          } else if (e.code == 'invalid-credential') {
            Fluttertoast.showToast(
              msg: "Incorrect email or password",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color(0xFFEF4444),
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        }
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: AppBar(backgroundColor: Color(0xFF0A1020)),
      body: Container(
        padding: EdgeInsets.all(14),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A1020), Color.fromARGB(255, 17, 26, 54)],
            end: Alignment.bottomRight,
            begin: Alignment.topLeft,
          ),
        ),

        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Lottie.asset(
                      'assets/Images/logo_animation.json',
                      repeat: false,
                      height: 170,
                      width: 150,
                    ),
                    //SizedBox(height: 10),
                    Text(
                      'Welcome back!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 37,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Login to continue shipping',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              CustomTextField(
                label: 'Email Address',
                icon: Iconsax.sms,
                TextEditingController: emailcontroller2,
              ),

              SizedBox(height: 13),
              CustomTextField(
                label: 'Password',
                icon: Iconsax.lock,
                TextEditingController: passwordcontroller2,
              ),
              SizedBox(height: 17),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2F6BFF),
                    padding: EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 13,
                    ),
                  ),
                  onPressed: () {
                    login();
                  },
                  child: Text(
                    'Login ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Divider(color: Colors.white54, endIndent: 59, indent: 59),
                  Text("OR", style: TextStyle(color: Colors.white54)),
                  Divider(color: Colors.white54, endIndent: 59, indent: 59),
                ],
              ),
              SizedBox(height: 20),
              custombutton(
                Logo: 'assets/Images/google_logo.png',
                text: 'Continue with Google',
                onTap: () async {
                  await GoogleSign().signInWithGoogle();
                  if (!mounted) return;
                  Navigator.pushNamed(context, AppRoutes.welcome);
                },
              ),
              SizedBox(height: 10),
              custombutton(
                Logo: 'assets/Images/apple_logo.png',
                text: 'Continue with Apple',
                onTap: () {},
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an Account?',
                    style: TextStyle(color: Colors.white54),
                  ),
                  SizedBox(width: 0),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.signup);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Color(0xFF2F6BFF)),
                    ),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
