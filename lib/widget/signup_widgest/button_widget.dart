import 'package:flutter/material.dart';

class custombutton extends StatelessWidget {
  final Logo;
  final String text;
  final VoidCallback onTap;
  const custombutton({
    super.key,
    required this.Logo,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(right: 25, left: 5),
                child: Image.asset(Logo, height: 60, width: 60),
              ),
            ),

            Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
