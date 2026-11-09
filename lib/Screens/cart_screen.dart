import 'package:e_commerce_app/Routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/Providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';

class CartScreen1 extends StatefulWidget {
  const CartScreen1({super.key});

  @override
  State<CartScreen1> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen1> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Scaffold(
      bottomSheet: Container(
        decoration: BoxDecoration(color: Color(0xFF12233F)),
        padding: EdgeInsets.all(10),
        height: 190,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Subtotal',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 18,
                      fontWeight: FontWeight(400),
                    ),
                  ),
                  Spacer(),
                  Text(
                    cart.total.toString(),
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 18,
                      fontWeight: FontWeight(400),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Shipping',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 18,
                      fontWeight: FontWeight(400),
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$${0}',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 17,
                      fontWeight: FontWeight(400),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight(700),
                    ),
                  ),
                  Spacer(),
                  Text(
                    cart.total.toStringAsFixed(1),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight(400),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  backgroundColor: Color(0xFF2F6BFF),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.CheckoutScreen);
                },
                child: Text(
                  'Move to Checkout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight(700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF0A1020),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF0A1020),
            flexibleSpace: Padding(
              padding: const EdgeInsetsGeometry.fromLTRB(9, 30, 9, 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Iconsax.arrow_left_2, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  Text(
                    'My Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      cart.clear();
                    },
                    child: Text(
                      'Clear all',
                      style: TextStyle(color: Color(0xFF2F6BFF), fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (cart.items.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.shopping_cart,
                      size: 90,
                      color: Colors.white24,
                    ),
                    Text(
                      'Cart is Empty',
                      style: TextStyle(
                        color: Colors.white24,
                        fontSize: 30,
                        fontWeight: FontWeight(800),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsetsGeometry.all(16),
              sliver: SliverList.separated(
                itemCount: cart.items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 22),

                itemBuilder: (context, i) {
                  final item = cart.items[i];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2F6BFF)
                              .withValues(alpha: 0.23),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 1,
                      color: const Color(0xFF12233F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(18),
                        side: BorderSide(color: Color(0xFF2F6BFF), width: 1.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 95,
                              width: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(10),
                                child: Image.network(
                                  item.imageurl,

                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 5, 2),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,

                                          item.name,
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 17,
                                            fontWeight: FontWeight(600),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '\$${item.price.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 14,
                                            fontWeight: FontWeight(500),
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            cart.decrease(
                                              item.id,
                                              item.quantity,
                                            );
                                          },
                                          icon: Icon(
                                            Iconsax.minus_cirlce,
                                            color: Colors.white54,
                                          ),
                                        ),
                                        Text(
                                          '${item.quantity}',
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 14,
                                            fontWeight: FontWeight(800),
                                          ),
                                        ),

                                        IconButton(
                                          onPressed: () {
                                            cart.increase(item.id);
                                          },
                                          icon: Icon(
                                            Iconsax.add_circle,
                                            color: Colors.white60,
                                          ),
                                        ),
                                        Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            cart.remove(item.id);
                                          },
                                          icon: Icon(
                                            Iconsax.trash,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
