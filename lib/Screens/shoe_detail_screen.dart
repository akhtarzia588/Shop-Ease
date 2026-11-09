import 'package:e_commerce_app/Providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShoeDetailScreen extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const ShoeDetailScreen({super.key, required this.documentSnapshot});

  @override
  State<ShoeDetailScreen> createState() => _ShoeDetailScreenState();
}

class _ShoeDetailScreenState extends State<ShoeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},

        elevation: 0,
        backgroundColor: Color(0xFF0A1020),
        label: Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                backgroundColor: Color(0xFF2F6BFF),
              ),
              onPressed: () async {
                debugPrint('1. button pressed');
                await context.read<CartProvider>().add(
                  id: widget.documentSnapshot.id,
                  name: widget.documentSnapshot['name'],
                  imageurl: widget.documentSnapshot['imageurl'],
                  price: (widget.documentSnapshot['price'] as num).toDouble(),
                );
                debugPrint('3. add finished');
                if (!context.mounted) return;
                Fluttertoast.showToast(
                  msg: "Add to Cart",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: const Color.fromARGB(255, 54, 244, 155),
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: Text(
                'Add to Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight(700),
                ),
              ),
            ),
            SizedBox(width: 10),
            IconButton(
              style: IconButton.styleFrom(
                shape: CircleBorder(
                  side: BorderSide(color: Colors.grey.shade300, width: 2),
                ),
              ),
              icon: Icon(Icons.favorite),
              onPressed: () {},
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF0A1020),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 50),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.documentSnapshot['imageurl'],
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.documentSnapshot['imageurl'],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  right: 10,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Iconsax.arrow_left_2,
                          size: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Iconsax.notification1,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.width,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 40,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.documentSnapshot['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Iconsax.star1,
                            color: Colors.amber[300],
                            size: 20,
                          ),
                          SizedBox(width: 2),
                          Text(
                            widget.documentSnapshot['ratings'],
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 15,
                              fontWeight: FontWeight(800),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '(${widget.documentSnapshot['reviews']} reviews)',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 13,
                              fontWeight: FontWeight(500),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$${widget.documentSnapshot['price']}'.toString(),
                        style: TextStyle(
                          color: Color(0xFF2F6BFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8),

                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(),
                        height: 300,
                        width: 330,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              widget.documentSnapshot['description'],
                              style: TextStyle(
                                color: Colors.white60,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
