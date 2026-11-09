import 'package:e_commerce_app/widget/Home/shoes_item_display.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

class ShowAllProduct extends StatefulWidget {
  const new({super.key});

  @override
  State<ShowAllProduct> createState() => _ShowAllProductState();
}

class _ShowAllProductState extends State<ShowAllProduct> {
  final CollectionReference complete_app = FirebaseFirestore.instance
      .collection('products');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1020),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            elevation: 2,
            backgroundColor: Color(0xFF0A1020),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadiusGeometry.vertical(),
            ),
            flexibleSpace: Container(
              padding: const EdgeInsets.fromLTRB(12, 35, 12, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Iconsax.arrow_left_2,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),

                          Text(
                            'All Products',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                StreamBuilder(
                  stream: complete_app.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          return GridView.builder(
                            itemCount: streamSnapshot.data!.docs.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                            itemBuilder: ((context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];
                              return Column(
                                children: [
                                  ShoesItemDisplay(
                                    documentSnapshot: documentSnapshot,
                                  ),
                                ],
                              );
                            }),
                          );
                        }
                        return Center(
                          child: Lottie.asset("assets/lottie/loading.json"),
                        );
                      },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
