import 'package:e_commerce_app/Providers/cart_provider.dart';
import 'package:e_commerce_app/widget/Home/banner.dart';
import 'package:e_commerce_app/widget/Home/search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/widget/Home/shoes_item_display.dart';
import 'package:geolocator/geolocator.dart';
import 'package:e_commerce_app/Services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String address = 'Detecting location...';
  String category = 'All';

  final CollectionReference categoriesitems = FirebaseFirestore.instance
      .collection('category_app');
  Query get filteredshoes => FirebaseFirestore.instance
      .collection('products')
      .where(
        /*this category is firebase field */ 'category',
        isEqualTo: /*It's our String */ category,
      );
  Query get allShoes => FirebaseFirestore.instance.collection('products');
  Query get selectedItems => category == 'All' ? allShoes : filteredshoes;

  @override
  void initState() {
    super.initState();
    _loadLocation(); // Home khulte hi location maango
  }

  Future<void> _loadLocation() async {
    final result = await LocationService().getCurrentLocation();
    if (!mounted) return;

    if (result.status == LocationStatus.success) {
      setState(() => address = result.address ?? 'Unknown');
    } else if (result.status == LocationStatus.serviceDisabled) {
      setState(() => address = 'Location is off');
      Geolocator.openLocationSettings();
    } else if (result.status == LocationStatus.deniedForever) {
      setState(() => address = 'Permission needed');
      Geolocator.openAppSettings();
    } else {
      setState(() => address = 'Location unavailable');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1020),

      body: CustomScrollView(
        slivers: [
          // ___________________APP BAR____________________________
          SliverAppBar(
            pinned: true,
            elevation: 2,

            backgroundColor: Color(0xFF0A1020),

            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadiusGeometry.vertical(),
            ),
            flexibleSpace: Container(
              padding: const EdgeInsets.fromLTRB(12, 32, 12, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: _loadLocation,
                        icon: const Icon(
                          Iconsax.location,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              const Text(
                                'deliver to',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white54,
                                ),
                              ),

                              Text(
                                address,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Badge(
                              isLabelVisible:
                                  context.watch<CartProvider>().count > 0,
                              label: Text(
                                '${context.watch<CartProvider>().count}',
                              ),
                              child: const Icon(
                                Iconsax.notification1,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/CartScreen');
                            },
                            icon: Badge(
                              isLabelVisible:
                                  context.watch<CartProvider>().count > 0,
                              label: Text(
                                '${context.watch<CartProvider>().count}',
                              ),
                              child: const Icon(
                                Iconsax.shopping_cart,
                                color: Colors.white,
                              ),
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

          //______________________BODY_____________________________
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  const Searchingbar(),
                  SizedBox(height: 10),
                  const banner(),
                  SizedBox(height: 15),
                  selectedCategory(),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Showing ${category} Shoes',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/showallproduct');
                        },
                        child: Text(
                          'See All',
                          style: TextStyle(
                            color: Color(0xFF2F6BFF),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  StreamBuilder(
                    stream: selectedItems.snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            final List<DocumentSnapshot> products =
                                streamSnapshot.data?.docs ?? [];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: products
                                      .map(
                                        (e) => ShoesItemDisplay(
                                          documentSnapshot: e,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            );
                          }
                          return Center(
                            child: Lottie.asset(
                              'assets/Images/loading.json',
                              width: 100,
                              repeat: true,
                            ),
                          );
                        },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> selectedCategory() {
    return StreamBuilder(
      stream: categoriesitems.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasError) {
          return Center(
            child: Text(
              "Firestore Error:\n${streamSnapshot.error}",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (streamSnapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                streamSnapshot.data!.docs.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      category = streamSnapshot.data!.docs[index]['name'];
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),

                      color:
                          category == streamSnapshot.data!.docs[index]['name']
                          ? Color(0xFF2F6BFF)
                          : Colors.white.withValues(alpha: 0.20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      streamSnapshot.data!.docs[index]['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color:
                            category == streamSnapshot.data!.docs[index]['name']
                            ? Colors.white
                            : Color(0xFF2F6BFF),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return Center(
          child: Lottie.asset(
            'assets/Images/loading.json',
            width: 100,
            repeat: true,
          ),
        );
      },
    );
  }
}
