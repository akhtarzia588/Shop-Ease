import 'package:cloud_firestore/cloud_firestore.dart';

class Userdetails {
  Future addUserDetails(String uid, Map<String, dynamic> data) async {
    return await FirebaseFirestore.instance
        .collection('userinfo')
        .doc(uid)
        .set(data, SetOptions(merge: true));
  }
}
