import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_const.dart';

class RegisterUserFirebase {
  final String fullName;
  final String email;
  final String password;
  final String address;

  RegisterUserFirebase({
    required this.fullName,
    required this.email,
    required this.password,
    required this.address,
  });

  Future registerToDatabase() async {
    await authInstance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;

    user.updateDisplayName(fullName);
    user.reload();

    await FirebaseFirestore.instance.collection('users').doc(_uid).set(
      {
        'id': _uid,
        'name': fullName,
        'email': email,
        'shipping-address': address,
        'userWish': [],
        'userCart': [],
        'createdAt': Timestamp.now(),
      },
    );
  }
}
