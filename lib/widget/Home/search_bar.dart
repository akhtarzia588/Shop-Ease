import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Searchingbar extends StatelessWidget {
  const Searchingbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        color: Colors.white.withValues(alpha: 0.20),
      ),
      height: 55,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(9),
        child: Row(
          children: [
            Icon(Iconsax.search_favorite, color: Colors.white70),
            SizedBox(width: 10),
            Text('Search for produts', style: TextStyle(color: Colors.white60)),
          ],
        ),
      ),
    );
  }
}
