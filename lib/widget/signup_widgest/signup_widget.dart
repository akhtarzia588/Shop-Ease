import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController;
  const new({
    super.key,
    required this.label,
    required this.icon,
    required this.TextEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController,
      style: TextStyle(
        color: Colors.white60,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white12,
        focusColor: Colors.white,
        contentPadding: EdgeInsets.all(3),
        prefixIcon: Icon(icon, color: Colors.white38, size: 22),
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.white38,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
