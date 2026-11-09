import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:e_commerce_app/Screens/shoe_detail_screen.dart';

class ShoesItemDisplay extends StatelessWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const ShoesItemDisplay({super.key, required this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ShoeDetailScreen(documentSnapshot: documentSnapshot),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withValues(alpha: 0.20),
        ),
        height: 270,
        margin: EdgeInsets.only(left: 5, right: 5),
        width: 200,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: documentSnapshot['imageurl'],
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          documentSnapshot['imageurl'].toString().trim(),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  documentSnapshot['name'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),

                Text(
                  '\$${documentSnapshot['price']}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 5,
              right: 5,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: InkWell(onTap: () {}, child: Icon(Iconsax.heart5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
