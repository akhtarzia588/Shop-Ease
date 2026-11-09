import 'package:e_commerce_app/Screens/categoryProductsScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1020),
      body: CustomScrollView(
        slivers: [
          // ---------- App bar ----------
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            elevation: 2,
            backgroundColor: const Color(0xFF0A1020),
            flexibleSpace: Container(
              padding: const EdgeInsets.fromLTRB(12, 50, 12, 0),
              child: Row(
                children: [
                  SizedBox(width: 20),
                  const Text(
                    'Categories',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ---------- List (sliver, koi ListView nahi) ----------
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('category_app')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              }

              final docs = snapshot.data!.docs.where((d) {
                final data = d.data() as Map<String, dynamic>;
                return (data['name'] ?? '').toString().trim() != 'All';
              }).toList();

              if (docs.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(
                      child: Text(
                        'No categories yet',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.all(14),
                sliver: SliverList.separated(
                  itemCount: docs.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, i) {
                    final data = docs[i].data() as Map<String, dynamic>;
                    final name = (data['name'] ?? '').toString().trim();
                    final imageUrl = (data['imageurl'] ?? '').toString().trim();

                    return _categoryCard(context, name, imageUrl);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ---------- Ek category ka card ----------
  Widget _categoryCard(BuildContext context, String name, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryProductsScreen(category: name),
          ),
        );
      },
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: const Color(0xFF111A36),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(20),
              ),
              child: SizedBox(
                width: 110,
                height: 110,
                child: imageUrl.isEmpty
                    ? Container(color: const Color(0xFF2F6BFF))
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) =>
                            Container(color: const Color(0xFF2F6BFF)),
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'View all products',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF2F6BFF),
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
