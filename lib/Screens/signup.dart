import 'package:e_commerce_app/Database/Userdetails.dart';
import 'package:e_commerce_app/Routes/app_routes.dart';
import 'package:e_commerce_app/Services/google_signin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_commerce_app/widget/signup_widgest/button_widget.dart';
import 'package:e_commerce_app/widget/signup_widgest/signup_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller1 = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController passwordcontroller1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    uploaddata(String uid) async {
      Map<String, dynamic> data = {
        'Full Name': namecontroller.text,
        'Email': emailcontroller1.text,
        'Phone Number': phonecontroller.text,
        'provider': 'password',
      };
      await Userdetails().addUserDetails(uid, data);
    }

    registration() async {
      if (passwordcontroller1 != null) {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                email: emailcontroller1.text,
                password: passwordcontroller1.text,
              );
          final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailcontroller1.text,
            password: passwordcontroller1.text,
          );
          await uploaddata(cred.user!.uid);
          Fluttertoast.showToast(
            msg: "Registration Successfull",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color(0xFF22C55E),
            textColor: Colors.white,
            fontSize: 16.0,
          );

          Navigator.pushNamed(context, AppRoutes.welcome);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Fluttertoast.showToast(
              msg: "Password Weak",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color(0xFFF59E0B),
              textColor: Colors.white,
              fontSize: 16.0,
            );
          } else if (e.code == 'email-already-in-use') {
            Fluttertoast.showToast(
              msg: "Email already in use",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color(0xFFEF4444),
              textColor: Colors.white,
              fontSize: 16.0,
            );
          } else if (e.code == 'network-request-failed') {
            Fluttertoast.showToast(
              msg: "No internet",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color(0xFF64748B),
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        }
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: Color(0xFF0A1020)),
      body: Container(
        padding: const EdgeInsets.all(14),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0A1020), Color.fromARGB(255, 17, 26, 54)],
            end: Alignment.bottomRight,
            begin: Alignment.topLeft,
          ),
        ),

        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 37,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Join us and start shopping today ',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: 'Full Name',
                icon: Iconsax.profile_add,
                TextEditingController: namecontroller,
              ),
              const SizedBox(height: 13),
              CustomTextField(
                label: 'Email Address',
                icon: Iconsax.sms,
                TextEditingController: emailcontroller1,
              ),
              const SizedBox(height: 13),
              CustomTextField(
                label: 'Phone Number',
                icon: Iconsax.call,
                TextEditingController: phonecontroller,
              ),
              const SizedBox(height: 13),
              CustomTextField(
                label: 'Password',
                icon: Iconsax.lock,
                TextEditingController: passwordcontroller1,
              ),
              const SizedBox(height: 17),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F6BFF),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 13,
                    ),
                  ),
                  onPressed: registration,

                  child: const Text(
                    'Create Account ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Divider(
                    color: Colors.white54,
                    endIndent: 59,
                    indent: 59,
                  ),
                  const Text("OR", style: TextStyle(color: Colors.white54)),
                  const Divider(
                    color: Colors.white54,
                    endIndent: 59,
                    indent: 59,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              custombutton(
                Logo: 'assets/Images/google_logo.png',
                text: 'Continue with Google',
                onTap: () async {
                  await GoogleSign().signInWithGoogle();
                  if (!mounted) return;
                  Navigator.pushNamed(context, AppRoutes.welcome);
                },
              ),
              const SizedBox(height: 10),
              custombutton(
                Logo: 'assets/Images/apple_logo.png',
                text: 'Continue with Apple',
                onTap: () {},
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an Account?',
                    style: TextStyle(color: Colors.white54),
                  ),
                  const SizedBox(width: 0),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.signin);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Color(0xFF2F6BFF)),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
