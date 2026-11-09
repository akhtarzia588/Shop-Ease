import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String name;
  final String imageurl;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.imageurl,
    required this.price,
    required this.quantity,
  });

  factory CartItem.fromMap(String id, Map<String, dynamic> m) => CartItem(
    id: id,
    name: (m['name'] ?? '').toString(),
    imageurl: (m['imageurl'] ?? '').toString().trim(),
    price: double.tryParse((m['price'] ?? 0).toString()) ?? 0,
    quantity: (m['quantity'] ?? 1) as int,
  );
}

class CartProvider extends ChangeNotifier {
  List<CartItem> _items = [];
  StreamSubscription? _cartsubs;
  StreamSubscription? _cartauth;
  String? _uid;

  CartProvider() {
    _cartauth = FirebaseAuth.instance.authStateChanges().listen((user) {
      _cartsubs?.cancel();
      _items = [];
      _uid = user?.uid;

      if (user != null) {
        _cartsubs = _cartRef(user.uid).snapshots().listen((snap) {
          _items = snap.docs
              .map((d) => CartItem.fromMap(d.id, d.data()))
              .toList();
          notifyListeners();
        });
      }
      notifyListeners();
    });
  }

  CollectionReference<Map<String, dynamic>> _cartRef(String uid) =>
      FirebaseFirestore.instance
          .collection('userinfo')
          .doc('uid')
          .collection('cart');

  List<CartItem> get items => _items;
  int get count => _items.fold(0, (sum, i) => sum + i.quantity);
  double get total => _items.fold(0.0, (sum, i) => sum + i.price * i.quantity);

  Future<void> add({
    required String id,
    required String name,
    required String imageurl,
    required double price,
  }) async {
    if (_uid == null) return;
    final ref = _cartRef(_uid!).doc(id);
    final snap = await ref.get();

    if (snap.exists) {
      await ref.update({'quantity': FieldValue.increment(1)});
    } else {
      await ref.set({
        'name': name,
        'imageurl': imageurl,
        'price': price,
        'quantity': 1,
      });
    }
  }

  Future<void> increase(String id) async {
    if (_uid == null) return;
    await _cartRef(_uid!).doc(id).update({'quantity': FieldValue.increment(1)});
  }

  Future<void> total2() async {
    _items.fold(0.0, (sum, i) => sum + i.price * i.quantity);
  }

  Future<void> decrease(String id, Currentqty) async {
    if (_uid == null) return;

    final ref = _cartRef(_uid!).doc(id);
    if (Currentqty <= 1) {
      await ref.delete();
    } else {
      await ref.update({'quantity': FieldValue.increment(-1)});
    }
  }

  Future<void> remove(String id) async {
    if (_uid == null) return;
    await _cartRef(_uid!).doc(id).delete();
  }

  Future<void> clear() async {
    if (_uid == null) return;
    final batch = FirebaseFirestore.instance.batch();
    for (final i in _items) {
      batch.delete(_cartRef(_uid!).doc(i.id));
    }
    await batch.commit();
  }

  @override
  void dispose() {
    _cartauth?.cancel();
    _cartsubs?.cancel();
  }

  static const double deliveryfees = 5;
  double get grandtotal => _items.isEmpty ? 0 : total + deliveryfees;

  Future<String> placeOrder({
    required String address,
    required String phone,
    required String paymentmethod,
  }) async {
    if (_uid == null) throw Exception('Please Login First');
    if (_items.isEmpty) throw Exception('Cart is Empty');

    final db = FirebaseFirestore.instance;
    final orderRef = db
        .collection('userinfo')
        .doc('_uid')
        .collection('order')
        .doc();

    final batch = db.batch();
    batch.set(orderRef, {
      'items': _items
          .map(
            (i) => {
              'id': i.id,
              'name': i.name,
              'imageurl': i.imageurl,
              'price': i.price,
              'quantity': i.quantity,
            },
          )
          .toList(),
      'subtotal': total,
      'delivery fees': deliveryfees,
      'total': grandtotal,
      'address': address,
      'phone': phone,
      'paymentmethod': paymentmethod,
      'status': 'placed',
      'createdAt': FieldValue.serverTimestamp(),
    });

    for (final i in _items) {
      batch.delete(_cartRef(_uid!).doc(i.id));
    }
    await batch.commit();
    return orderRef.id;
  }
}
