import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';


abstract class BaseAuth {
  Future<bool> checkUserExists(String email);
}

class Auth implements BaseAuth {
  
final Firestore _firebaseStore = Firestore.instance;

  Future<bool> checkUserExists(String email) async {
    final snapshot =
        await _firebaseStore.collection("Users").document(email).get();
    if (snapshot.exists) {
      /*How to get primitive value of a future */
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}